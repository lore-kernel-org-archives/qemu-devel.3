Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF13D10F43
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 13:00:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOF88-0001F3-4v; Wed, 26 Nov 2025 08:00:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vOF7k-0000uW-GJ
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 07:59:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vOF7i-0001Ku-Bv
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 07:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764161992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SsjkXx6OaswXl8ikDM5Biep/jkNZbnax5RCRyj0b6nc=;
 b=G9Cwx1EL28Gf0E3+oF2aehj+/MRY86OaKvjLT7I8kOF165hRil3v0JVqb2pxvxOCa+P+1W
 F8K6w0mJFjWR1YsZWwUQcKtMKOrx8Ur3TkMc3DzziCwADfwF9AEypHtp7Bpf6HdYlr6ZT3
 fqpBVicokqHPkRtcbJSgs3Y3kvLczpY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-8iKjtOhePgi6s_4qdjpJ8g-1; Wed,
 26 Nov 2025 07:59:48 -0500
X-MC-Unique: 8iKjtOhePgi6s_4qdjpJ8g-1
X-Mimecast-MFC-AGG-ID: 8iKjtOhePgi6s_4qdjpJ8g_1764161988
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C466180122B; Wed, 26 Nov 2025 12:59:47 +0000 (UTC)
Received: from localhost (dhcp-192-239.str.redhat.com [10.33.192.239])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7238518004D8; Wed, 26 Nov 2025 12:59:46 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Eric Auger
 <eric.auger@redhat.com>
Subject: Re: [PATCH for-11.0] arm: add DCZID_EL0 to idregs array
In-Reply-To: <CAFEAcA_zXVk39GzeMeTtpMVPr5xm23H7RPzbvX9Sxhgr=WzN+Q@mail.gmail.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20251119134414.2892640-1-cohuck@redhat.com>
 <CAFEAcA8r7_6fbEFtkEL4vi-wqABewcPU3P73RWh08RRQnQ5Baw@mail.gmail.com>
 <87see2ozzu.fsf@redhat.com>
 <CAFEAcA_zXVk39GzeMeTtpMVPr5xm23H7RPzbvX9Sxhgr=WzN+Q@mail.gmail.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Wed, 26 Nov 2025 13:59:44 +0100
Message-ID: <875xaxosov.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Nov 25 2025, Peter Maydell <peter.maydell@linaro.org> wrote:

> On Tue, 25 Nov 2025 at 16:09, Cornelia Huck <cohuck@redhat.com> wrote:
>>
>> On Mon, Nov 24 2025, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> > On Wed, 19 Nov 2025 at 13:44, Cornelia Huck <cohuck@redhat.com> wrote:
>> >>
>> >> This requires a bit of care, since we still have to handle the EL
>> >> specific part (DCZID_EL0.DZP). Callers can set/access dcz_blocksize
>> >> via a wrapper working on DCZID_EL.BS.
>> >>
>> >> KVM currently does not support DCZID_EL0 via ONE_REG, and actually
>> >> does not need to work with it, so provide a dummy value for now.
>> >
>> > That seems like an odd (unintended?) omission -- is it worth
>> > adding? (We would need to handle older kernels that don't
>> > expose it anyway, of course.)
>>
>> I'm not sure whether there's actually a usecase for KVM exposing this to
>> the VMM - AFAICS, KVM doesn't do anything special for DC ZVA and
>> friends, and doesn't tweak HCR_EL2.TDZ which would change behaviour.
>
> I guess the only one I can think of is to correctly fail
> migration from a source CPU with a DCZID_EL0.BS that doesn't
> match the one on the destination CPU. (We can't lie to the
> guest about the blocksize as part of "tell the guest it has
> a different CPU type from the actual host" unless we want to
> trap and emulate all the DC ZVA etc insns...)

Agreed.

Might actually be best to assert that kvm code is not doing anything
with the reg, rather than providing a dummy value. I'll respin.


