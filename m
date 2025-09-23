Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF23CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 11:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v10ss-0000ME-DC; Tue, 23 Sep 2025 07:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v10sp-0000KV-Gh
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 07:08:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v10sk-0002dK-VI
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 07:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758625703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OdV6zZM9+UhCz/Bm0hHSS5IF3oHAV5ERnrjFjEblDTo=;
 b=jKPnblXFXOOFaiymSQVSO/4fad1d68MhgrOcZHyhZ9MGiAZd2HncgqYHmMkH7nniSvwEDF
 J/5+WhTsyRbfbyXXifZKUO68qG15n0G2QC6wVJvWb3+yK6+OUE92IB+ofemttR+VuZs4cB
 bJH7735+4N9KiqxdFeRvZhyYaZfq8Po=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-drP9evCyM6eE9yRc85n56A-1; Tue,
 23 Sep 2025 07:08:18 -0400
X-MC-Unique: drP9evCyM6eE9yRc85n56A-1
X-Mimecast-MFC-AGG-ID: drP9evCyM6eE9yRc85n56A_1758625697
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7E7A18002E9; Tue, 23 Sep 2025 11:08:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.33])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1245D19560BB; Tue, 23 Sep 2025 11:08:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 56D5B21E6A27; Tue, 23 Sep 2025 13:08:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  odaki@rsg.ci.i.u-tokyo.ac.jp,
 marcandre.lureau@redhat.com,  berrange@redhat.com,
 richard.henderson@linaro.org,  vsementsov@yandex-team.ru
Subject: Re: [PATCH v3 01/13] monitor: Clean up HMP gdbserver error reporting
In-Reply-To: <b4128c1c-04b0-4c7b-8d3a-edc443789b29@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 23 Sep 2025 11:54:06
 +0200")
References: <20250923091000.3180122-1-armbru@redhat.com>
 <20250923091000.3180122-2-armbru@redhat.com>
 <b4128c1c-04b0-4c7b-8d3a-edc443789b29@linaro.org>
Date: Tue, 23 Sep 2025 13:08:13 +0200
Message-ID: <87ldm5a0ki.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 23/9/25 11:09, Markus Armbruster wrote:
>> HMP command gdbserver used to emit two error messages for certain
>> errors.  For instance, with -M none:
>>      (qemu) gdbserver
>>      gdbstub: meaningless to attach gdb to a machine without any CPU.
>>      Could not open gdbserver on device 'tcp::1234'
>
> Orthogonal to this patch: interesting. This comes from commit
> 508b4ecc393 ("gdbstub.c: fix GDB connection segfault caused by empty
> machines"). This feels wrong to me, as it is OK to use a jtag probe
> to access memory or program a flash, even without any cpu online.
>
> Yet another side-effect of use of the ill-first_cpu global variable.
>
> Back to this patch description, probably not the best error example =3D)

I picked it because how to trigger it was obvious to me.

Happy to use another one if you show it to me :)

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Thanks!


