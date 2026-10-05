Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3ADCA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 21:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDqUc-00050I-GN; Mon, 05 Oct 2026 17:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fuad.tabba@linux.dev>)
 id 1xDqUb-000501-5P
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 17:45:05 -0400
Received: from out-183.mta0.migadu.com ([2001:41d0:1004:224b::b7]
 helo=mta0.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fuad.tabba@linux.dev>)
 id 1xDqUZ-00034q-6w
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 17:45:04 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=w0TIwQV2lUFcngUw95TlXoGDr2YHflHFzIEeIwp6s+Y=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791236696; v=1; x=1791841496;
 b=GAw2o/dcPMfyekXJ6FPEg9H6oyfHDnOytR3GgPf3xJBnngtIBLOMqqC1oUGqkgpuFYDRu/0N
 Kt1pCcvUOYhDNiCQTkdMi3CAEM2Ifc+hUeqySj2dlWmauVX78ZkthgySI90doIrLhk4oZ5a80Fq
 s7c/pOJhMLDdwQNM6D1J/pXY=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id e121de19412a3869;
 Mon, 05 Oct 2026 21:44:56 +0000
X-Mizu-Trace-ID: e121de19412a3869
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Gustavo Romero <gromero@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Will Deacon <will@kernel.org>, Itaru Kitayama <itaru.kitayama@linux.dev>,
 Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH 1/2] target/arm: Clear TTBR[5:0] from a 52-bit table base
 address
Date: Mon,  5 Oct 2026 22:44:51 +0100
Message-Id: <20261005214451.1036668-1-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <l5hcpwnktn2hvbt55ux42xzb2euc5zqohnxtaiftr7lxynfx2g@myyytd4e4owp>
References: <20261001175003.ttbr-baddr-52bit-0-fuad.tabba@linux.dev>
 <20261002070925.2627344-1-fuad.tabba@linux.dev>
 <l5hcpwnktn2hvbt55ux42xzb2euc5zqohnxtaiftr7lxynfx2g@myyytd4e4owp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:1004:224b::b7;
 envelope-from=fuad.tabba@linux.dev; helo=mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Hi Gustavo,

On Mon, 05 Oct 2026 21:06:44 +0100, Gustavo Romero <gromero@redhat.com> wrote:

[...]

> > diff --git a/tests/tcg/aarch64/system/ttbr-baddr.c b/tests/tcg/aarch64/system/ttbr-baddr.c

[...]

> > +int main(void)

[...]

> > +    /* PARange 52 bits, TGran16 with 52-bit addresses (FEAT_LPA2) */
> > +    if ((mmfr0 & 0xf) != 6 || ((mmfr0 >> 20) & 0xf) != 2) {
>
> I understand you are checking PARange == 6 here for checking if FEAT_LPA (not
> FEAT_LPA2) is also available? If so, maybe change the comment to:
>
> /* PARange 52 bits (FEAT_LPA) and TGran16 with 52-bit addresses (FEAT_LPA2) */
>
> ?

Yes, the test's 52-bit PA and IPA both require FEAT_LPA. I'll take
your comment for v2.

> > +        ml_printf("SKIP: no 52-bit PA or no FEAT_LPA2 with 16KB\n");
> > +        return 0;
>
> Return 'ret' here for consistence?

Sure, I'll change it in v2.

> That's a nice test.
>
> I'm wondering if the fixes should be separated from the tests as we usually do,
> but feel free to wait for collecting more input from the other reviewers about
> it.

Thanks! I kept each test case with the fix it covers, so each patch
carries a test case that fails without its fix. Both forms have gone
into target/arm, including my last contribution. Happy to split if you
prefer. I'll wait for more comments before doing that.

Cheers,
/fuad

