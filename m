Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A17C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 13:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x51R5-0007f2-Ol; Fri, 11 Sep 2026 09:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x51R4-0007eq-1T
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 09:36:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x51R0-00022m-LZ
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 09:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789133812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pc4UnH5dQuxx4CPlrx8/fAp4874tL2sA5nusMJcyInY=;
 b=FtOrKJCQh2bNAij0ehoMPrFpd+/u1eHnsNC7mIuec5fYINt2RscebpgZe4UGIconNsK6Rz
 FXNx0mk6lREdvdHkISssfYXgzMSbsd35OHsBNTTV7qNtKcd4XXXPa2eYC1QRJVBceLB62r
 29MqeSMKa+Ylid7817sljDyL1ov3EDk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-jU3dZqSMNUuLBk8MZxzI_A-1; Fri,
 11 Sep 2026 09:36:48 -0400
X-MC-Unique: jU3dZqSMNUuLBk8MZxzI_A-1
X-Mimecast-MFC-AGG-ID: jU3dZqSMNUuLBk8MZxzI_A_1789133807
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92FAB19540E3; Fri, 11 Sep 2026 13:36:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D40541B; Fri, 11 Sep 2026 13:36:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C4B8221E6A04; Fri, 11 Sep 2026 15:36:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel
 <qemu-devel@nongnu.org>,  Eric Blake <eblake@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>, Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH V16 00/13] iothread: Support tracking and querying
 IOThread holder
In-Reply-To: <CAK3tnvKXv+HdK4d5KXXNagUCODj68A1XRuP7VTpZNyUFoMTQnw@mail.gmail.com>
 (Zhang Chen's message of "Fri, 11 Sep 2026 20:53:50 +0800")
References: <20260911100709.726366-1-zhangckid@gmail.com>
 <87wlss6owr.fsf@pond.sub.org>
 <CAK3tnvKXv+HdK4d5KXXNagUCODj68A1XRuP7VTpZNyUFoMTQnw@mail.gmail.com>
Date: Fri, 11 Sep 2026 15:36:44 +0200
Message-ID: <87fqzf6har.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Zhang Chen <zhangckid@gmail.com> writes:

> On Fri, Sep 11, 2026 at 6:52=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> Doesn't apply to current master.
>>
>> https://patchew.org/QEMU/20260911100709.726366-1-zhangckid@gmail.com/
>
> This issue caused by the dropped patch 1 from V15.
> https://lists.gnu.org/archive/html/qemu-devel/2026-09/msg02947.html
>
> I assume that patch will be merged before this series.
> I forgot to mention this earlier, I double confirmed no other problem her=
e.
> please continue reviewing.=EF=BC=9A=EF=BC=89

The machine-readable way to mention this is

Based-on: <20260907063725.626685-2-zhangckid@gmail.com>

Next time :)


