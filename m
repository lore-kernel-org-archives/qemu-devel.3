Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55442C83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 05:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWq3S-0007RA-7H; Wed, 02 Jul 2025 01:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uWq3N-0007QX-Na
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 01:30:44 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uWq3H-000601-N6
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 01:30:41 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 87CAA45CD6;
 Wed,  2 Jul 2025 05:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C93AC4CEEE;
 Wed,  2 Jul 2025 05:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1751434230;
 bh=OG84wgHxG2C43MlwmX2KmakUB8kHfA4ec15ExwnbGTM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IMPtVqvvFMX6GdV5qZEonGBggXu1IhphaL4HBZNJkubi0hjBD7x/3St63CT1hyTUp
 8wDnoPIa+17F/EIBHy8JAyNwyagYVBtTw/f7RZEphol0TcU9XaNgLN/wOPHHdbR8J0
 je7HZvLuxOpFcHClBcDWtytbjdWstdRlKoCKgye0SNtqPQa6VAc8sYogC2Oa1V83ri
 mNqUAZ67mQM5Y5NQgNqEoua5M6xpwr38DW8ebokddjhyL/8gY5KVlc4gm/4GYQJtxK
 01tUhrWNrNUHwEX4fdEDtcmPLC/nVJalSEtd4L5JxuJPr8qEvSkPKvCbq4bwUD9JgD
 kJyPTacTYRGDg==
Date: Wed, 2 Jul 2025 05:30:28 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <liuwe@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 24/27] target/i386/mshv: Implement mshv_vcpu_run()
Message-ID: <aGTD9Fvk5nU2xwbp@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250701172834.44849-1-magnuskulke@linux.microsoft.com>
 <20250701172834.44849-25-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701172834.44849-25-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=wei.liu@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 01, 2025 at 07:28:31PM +0200, Magnus Kulke wrote:
> Add the main vCPU execution loop for MSHV using the MSHV_RUN_VP ioctl.
> 
> A translate_gva() hypercall is implemented. The execution loop handles
> guest entry and VM exits. There are handlers for memory r/w, PIO and
> MMIO to which the exit events are dispatched.
> 
> In case of MMIO the i386 instruction decoder/emulator is invoked to
> perform the operation in user space.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
[...]
> +
> +typedef struct X64Registers {
> +  const uint32_t *names;
> +  const uint64_t *values;
> +  uintptr_t count;

Need four spaces for indentation.

Wei.

