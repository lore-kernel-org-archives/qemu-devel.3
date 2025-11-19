Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40479CF58C6
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 18:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLmY6-0008Kt-2u; Wed, 19 Nov 2025 13:04:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fweimer@redhat.com>)
 id 1vLmY3-0008KU-Es
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 13:04:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fweimer@redhat.com>)
 id 1vLmY1-0002Fc-Lu
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 13:04:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763575489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yR2XmDKXscrOb2moacExky8fG2D5P/G8oQXBtIz0jGk=;
 b=SNBc/LXkhwmtIsohejMsdUMZnMtk5Rp9XeDajhIYbP4kQZC3a0VdLiqv9AIzTdizlRFP83
 LFXCkEywT6KobUZiS5O+BJVRBQmJ6QaqenNMIu51i8SErVxK4IsxEVTrP1T2TI1Squ1P4s
 F+DtCgXqzaxoitdnVBAgAGgu0nnZC6M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-eBrk9HEGPpGehBs0P-G-uA-1; Wed,
 19 Nov 2025 13:04:43 -0500
X-MC-Unique: eBrk9HEGPpGehBs0P-G-uA-1
X-Mimecast-MFC-AGG-ID: eBrk9HEGPpGehBs0P-G-uA_1763575482
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47CE318AB400; Wed, 19 Nov 2025 18:04:42 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.45.224.162])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 597C6180094C; Wed, 19 Nov 2025 18:04:39 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  qemu-devel@nongnu.org,
 kvm@vger.kernel.org,  "Chang S . Bae" <chang.seok.bae@intel.com>,  Zide
 Chen <zide.chen@intel.com>,  Xudong Hao <xudong.hao@intel.com>,  Peter
 Fang <peter.fang@intel.com>
Subject: Re: [PATCH 4/5] i386/cpu: Support APX CPUIDs
In-Reply-To: <aR1zIb4GHh9FrK31@intel.com> (Zhao Liu's message of "Wed, 19 Nov
 2025 15:34:57 +0800")
References: <20251118065817.835017-1-zhao1.liu@intel.com>
 <20251118065817.835017-5-zhao1.liu@intel.com>
 <CABgObfZfGrx3TvT7iR=JGDvMcLzkEDndj7jb5ZVV3G3rK54Feg@mail.gmail.com>
 <aR1zIb4GHh9FrK31@intel.com>
Date: Wed, 19 Nov 2025 19:04:36 +0100
Message-ID: <lhuh5upzyob.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=fweimer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

* Zhao Liu:

>> Please just make the new leaf have constant values based on just
>> APX_F. We'll add the optional NCI/NDD/NF support if needed, i.e.
>> never. :)
>
> Maybe not never?
>
>> > Note, APX_NCI_NDD_NF is documented as always enabled for Intel
>> > processors since APX spec (revision v7.0). Now any Intel processor
>> > that enumerates support for APX_F (CPUID.(EAX=3D0x7, ECX=3D1).EDX[21])
>> > will also enumerate support for APX_NCI_NDD_NF.
>
> This sentence (from APX spec rev.7) emphasizes the =E2=80=9CIntel=E2=80=
=9D vendor,
> and its primary goal was to address and explain compatibility concern
> for pre-enabling work based on APX spec v6. Prior to v7, APX included
> NCI_NDD_NF by default, but this feature has now been separated from
> basic APX and requires explicit checking CPUID bit.
>
> x86 ecosystem advisory group has aligned on APX so it may be possible
> for other x86 vendors to implement APX without NCI_NDD_NF and this still
> match with the APX spec.

Well yes, but I doubt that the ecosystem will produce binaries
specialized for APX *without* NDD.  It's fine to enumerate it
separately, but that doesn't have any immediate consequences.  GCC makes
it rather hard to build for APX without NDD, for example.  At least more
difficult than building for AVX-512F without AVX-512VL.

I just don't think software vendors are enthusiastic about having to
create and support not one, but two builds for APX.  If NDD is optional
in practice, it will not be possible to use it except for run-time
generated code and perhaps very targeted optimizations because that
single extra APX will just not use NDD.

I feel like there has been a misunderstanding somewhere.

(sorry for off-topic)

Thanks,
Florian


