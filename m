Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879C1C624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ifZ-0004wU-Mc; Wed, 02 Sep 2026 06:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x1ifY-0004vd-5N
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 06:58:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x1ifW-0002mw-ML
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 06:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788346693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7+UEKLtsaCzDnBKoVmouTtNhyD+702Q9U72xApd5tiU=;
 b=hGG+hdjiJH/29gAu9wW6C1WrKjCMnFFdrUCBS2CQilsve83VB/IHLHJT3QYzRBz406QF4x
 AhwrRL+Zke1HurqL5MudX2fQrmIdpgovyxX67NPA5eCYikVZcWhTTHonqhaXJTRLHcaORz
 IchbgQsA0kwpTd84klzVg45T16TVf+Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-Q6nYtSvfOam0ZIwu0RxKew-1; Wed,
 02 Sept 2026 06:58:10 -0400
X-MC-Unique: Q6nYtSvfOam0ZIwu0RxKew-1
X-Mimecast-MFC-AGG-ID: Q6nYtSvfOam0ZIwu0RxKew_1788346687
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AEDA81800A30; Wed,  2 Sep 2026 10:58:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 841C31800577; Wed,  2 Sep 2026 10:58:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1383721E682B; Wed, 02 Sep 2026 12:58:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  zhenwei pi <zhenwei.pi@linux.dev>,
 Jonathan Cameron <jic23@kernel.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  Jiri Pirko
 <jiri@resnulli.us>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,
 qemu-block@nongnu.org,  Ani Sinha <anisinha@redhat.com>,  Jason Wang
 <jasowangio@gmail.com>,  linux-cxl@vger.kernel.org,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Alex Williamson <alex@shazbot.org>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,  linux-edac@vger.kernel.org,  Michael
 Tokarev <mjt@tls.msk.ru>,  Fabiano Rosas <farosas@suse.de>,  Zhao Liu
 <zhao1.liu@intel.com>,  "Gonglei (Arei)" <arei.gonglei@huawei.com>,  Eric
 Blake <eblake@redhat.com>,  Peter Xu <peterx@redhat.com>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Mauro Carvalho
 Chehab <mchehab+huawei@kernel.org>,  qemu-trivial@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH v4 00/43] qapi: convert (very) trivial intro sections
In-Reply-To: <CAFn=p-YBpsxy-3tr0SZ0CBfXUYnb6eg6AxNWpwUQmsuY5ZuykA@mail.gmail.com>
 (John Snow's message of "Tue, 1 Sep 2026 13:01:49 -0400")
References: <20260831201945.287730-1-jsnow@redhat.com>
 <871pbd9qpy.fsf@pond.sub.org>
 <CAFn=p-YBpsxy-3tr0SZ0CBfXUYnb6eg6AxNWpwUQmsuY5ZuykA@mail.gmail.com>
Date: Wed, 02 Sep 2026 12:58:00 +0200
Message-ID: <874ig7539j.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

John Snow <jsnow@redhat.com> writes:

> On Tue, Sep 1, 2026 at 7:05=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>>
>> Series
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>
>
> Thank you for your suffering :)

You're welcome; it's my job[*]!

> So, I think there's actually no real problem in checking in a partial
> conversion as the infrastructure was coded specifically to allow it,
> however you're the maintainer so I will follow your lead. I'm more
> interested in moving forward than telling you how to do your job ;)
>
> The series will eventually enforce strict ordering, so there is no
> chance we will miss anything. If we send a PR now, we also don't have
> to keep rebasing the partial series against master. If you don't want
> to submit a PR, please create a branch I can track and submit patches
> against, and please periodically rebase it against origin/master.

I worry a bit that having intros split about half between two styles
would cause confusion and friction.  I'd much prefer to get to >90%
fairly quickly.  If we think that's possible, I'm happy to queue up
things in my tree, and take care of the rebasing.


[*] Some days my compensation is compensation for suffering ;)


