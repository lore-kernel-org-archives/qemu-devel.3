Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA01D3943C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 14:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8JSo-0005vp-Cf; Thu, 02 Apr 2026 10:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1w8JSk-0005v9-3h
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 10:56:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1w8JSg-0005cW-B3
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 10:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775141754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3kZLxZzCffeG8n2GjmyKvm99bf53bl4b+fFN8fGqQIQ=;
 b=NHG04tkWB/noEJ84YfgNh7ZuePeJHlom7yLI/X/JFaX9DGQrrBdxomwYWoD9Hj081eu3c5
 kv4ojeBpgngEzclJVBF0NH6O9fB2k91wNg5iY0pPjveoRNOn+tbLpqOm5MASWwmNEBVowN
 KwNA05vOiZiuIgLcClNH4EIT02SeNyg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-GYSCOSJNM9CcJTeslY2vSg-1; Thu,
 02 Apr 2026 10:55:51 -0400
X-MC-Unique: GYSCOSJNM9CcJTeslY2vSg-1
X-Mimecast-MFC-AGG-ID: GYSCOSJNM9CcJTeslY2vSg_1775141750
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28118180049D; Thu,  2 Apr 2026 14:55:50 +0000 (UTC)
Received: from localhost (unknown [10.44.49.158])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6354B1800361; Thu,  2 Apr 2026 14:55:48 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: eric.auger@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/3] arm: handle demuxed ID registers
In-Reply-To: <b5315132-bedb-499a-9cf6-83132e8559a3@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260204133229.297061-1-cohuck@redhat.com>
 <20260204133229.297061-2-cohuck@redhat.com>
 <8ecca07b-7ff0-4a46-8de3-6a3f21173a00@linaro.org>
 <87bjg3drhf.fsf@redhat.com>
 <b5315132-bedb-499a-9cf6-83132e8559a3@redhat.com>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Thu, 02 Apr 2026 16:55:44 +0200
Message-ID: <875x69e7in.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Apr 01 2026, Eric Auger <eric.auger@redhat.com> wrote:

> On 4/1/26 10:17 AM, Cornelia Huck wrote:
>> On Thu, Feb 05 2026, Richard Henderson <richard.henderson@linaro.org> wr=
ote:
>>> I'm not keen on this.  Surely we don't expect all multiplexed ID regist=
ers to have the=20
>>> same number of sub-registers?  A rectangular matrix isn't a great repre=
sentation.  Also,=20
>>> you're wasting a hole in idregs[] with CSSIDR_EL1_IDX.
>>>
>>> Why not just have the N sub-registers occupy N entries within the regul=
ar idregs[]?=20
>>> Something like
>>>
>>> #define DEF_MUX(NAME, OP0, OP1, CRN, CRM, OP2, NUM) \
>>>      NAME##_DEMUX_IDX,                               \
>>>      NAME##_DEMUX_LAST =3D NAME##_DEMUX_IDX + NUM - 1,
>>>
>>> #define SET_IDREG_DEMUX(ISAR, REG, INDEX, VALUE)                       =
 \
>>>      ({                                                                =
  \
>>>          ARMISARegisters *i_ =3D (ISAR);                               =
    \
>>>          i_->idregs_demux[REG ## _EL1_DEMUX_IDX + INDEX] =3D VALUE;    =
    \
> I guess we would use regular i_-> idregs[] here, right?=C2=A0

Yes.

>
> Thanks
>
> Eric
>>>      })
>>>
>>> etc.
>> Yeah, I was not overly excited about my solution, either. I'll go and
>> play with this, thanks.
>>
>>


