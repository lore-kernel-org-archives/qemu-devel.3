Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1608ECA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 17:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulWgy-00050E-Pd; Mon, 11 Aug 2025 13:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1ulWgo-0004yo-Lc
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 13:52:08 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1ulWgg-0001YP-WE
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 13:52:05 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 06BBB5C5D52;
 Mon, 11 Aug 2025 17:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5544FC4CEF5;
 Mon, 11 Aug 2025 17:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1754934705;
 bh=lKNDlQW+qVt75sbDDF/3VmWWnLAPvdijuoipSzE0tyM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ig2AYE+l7weOmsqJqLlEOgcOvZLtNiTOvPtwoccvp4D4asXsTfgCM8kyHhNUNH2YZ
 0P4Z0N5C3bmSdtG+wdpsnH/gMizDfkYVuQzjZwbDEPVuo1LMc0QhCyYDX0ym4LSyGe
 EIOJlGi4WsM3a3JBhkvnJk8hBE1DRU+wx8Ei8XUnUXAplNTU6V1GM8Q5lg6m6YNEA4
 E5/guj1Q+04r+MrLgYIT9f+vfs/D3LUb9CEsw3zLPBUafK9C+HoTZc6xL/XrekJKSB
 j4juTMtRz75Oaabo8TEddOL3Shp8jC5l8YotWo/bscetU+woUVlOcN+GbO2pRgo8YI
 vsGm0+odYWtEw==
Date: Mon, 11 Aug 2025 17:51:44 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Magnus Kulke <magnus.kulke@microsoft.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>,
 Wei Liu <liuwe@microsoft.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 01/26] accel: Add Meson and config support for MSHV
 accelerator
Message-ID: <aJotsJZOsvjXMiel@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250807143951.1154713-1-magnuskulke@linux.microsoft.com>
 <20250807143951.1154713-2-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807143951.1154713-2-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=wei.liu@kernel.org; helo=dfw.source.kernel.org
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

On Thu, Aug 07, 2025 at 04:39:26PM +0200, Magnus Kulke wrote:
> Introduce a Meson feature option and default-config entry to allow
> building QEMU with MSHV (Microsoft Hypervisor) acceleration support.
> 
> This is the first step toward implementing an MSHV backend in QEMU.
> 
[...]
>  if get_option('whpx').allowed() and host_os == 'windows'
>    if get_option('whpx').enabled() and host_machine.cpu() != 'x86_64'
>      error('WHPX requires 64-bit host')
> @@ -4818,6 +4827,7 @@ if have_system
>    summary_info += {'HVF support':       config_all_accel.has_key('CONFIG_HVF')}
>    summary_info += {'WHPX support':      config_all_accel.has_key('CONFIG_WHPX')}
>    summary_info += {'NVMM support':      config_all_accel.has_key('CONFIG_NVMM')}
> +  summary_info += {'MSHV support':       config_all_accel.has_key('CONFIG_MSHV')}

Minor nit, one space too many here.

Wei

