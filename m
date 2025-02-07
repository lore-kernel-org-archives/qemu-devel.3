Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D8CC02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 21:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgVYL-0005Vp-Fz; Fri, 07 Feb 2025 16:06:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+283d3205a5fdf6ec7e2e+7838+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1tgVYI-0005Uu-Su; Fri, 07 Feb 2025 16:06:18 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+283d3205a5fdf6ec7e2e+7838+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1tgVYG-0001wl-7p; Fri, 07 Feb 2025 16:06:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
 :MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=LZO3COT8kUUb9a66R4TRMCeBBKOc0btjWfEndw9H1KY=; b=l5qEclpUeZ40bJSc747L1wcntK
 +EwqoEUUFCXt/4AzXtSJfM4VZYHcRU5N0CtxoJeWdTYWUAr0+DwUB2h+91ptSCiWSFHK6DCXul3av
 MnYBayP/s4n9U6CYUZcS4+W7fvHk2TI53BBM+sjuxlAOyt1hg0Z+gCTnYyarIEh3IpUtYUvJiqeGs
 /zIPOANuqOOR9GbxEYt9rlnt0U04f4XHgCgAJBy2zk+JlIx4nXgmrgbNKMPYKvstb2WCTT9qAQmkU
 u7KR7bl0F0OtkY/mje1VLvJxphkvCCvxzTiaou3N8iH2+qrBeWhNA5E44jQ4GPBmtvvJJ30yItHHf
 TaJo8auA==;
Received: from [2001:8b0:10b:5:4b09:6838:d292:2864] (helo=[IPv6:::1])
 by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1tgVY9-0000000HJY6-1q3T; Fri, 07 Feb 2025 21:06:09 +0000
Date: Fri, 07 Feb 2025 21:06:10 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Sean Christopherson <seanjc@google.com>
CC: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org, kvm@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/2=5D_i386/xen=3A_Move_KVM=5FXEN=5F?=
 =?US-ASCII?Q?HVM=5FCONFIG_ioctl_to_kvm=5Fxen=5Finit=5Fvcpu=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <Z6YoxFOaMdNiD_uv@google.com>
References: <20250207143724.30792-1-dwmw2@infradead.org>
 <Z6YoxFOaMdNiD_uv@google.com>
Message-ID: <A51B44C4-5D78-4D8A-A6EB-DA937377F6CE@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+283d3205a5fdf6ec7e2e+7838+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 7 February 2025 15:37:40 GMT, Sean Christopherson <seanjc@google=2Ecom> =
wrote:
>On Fri, Feb 07, 2025, David Woodhouse wrote:
>> From: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>>=20
>> At the time kvm_xen_init() is called, hyperv_enabled() doesn't yet work=
, so
>> the correct MSR index to use for the hypercall page isn't known=2E
>>=20
>> Rather than setting it to the default and then shifting it later for th=
e
>> Hyper-V case with a confusing second call to kvm_init_xen(), just do it
>> once in kvm_xen_init_vcpu()=2E
>
>Is it possible the funky double-init is deliberate, to ensure that Xen is
>configured in KVM during VM setup?  I looked through KVM and didn't see a=
ny
>obvious dependencies, but that doesn't mean a whole lot=2E

I am fairly sure there are no such dependencies=2E It was just this way be=
cause shifting the MSR to accommodate Hyper-V (and making kvm_xen_init() id=
empotent in order to do so) was an afterthought=2E In retrospect, I should =
have done it this way from the start=2E It's cleaner=2E And you don't requi=
re as much caffeine to understand it :)

