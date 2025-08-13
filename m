Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B89CCA0EE0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 12:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umAwe-0003wx-MW; Wed, 13 Aug 2025 08:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregkh@linuxfoundation.org>)
 id 1umAwb-0003wl-3P
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 08:51:05 -0400
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregkh@linuxfoundation.org>)
 id 1umAwT-0001kv-I0
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 08:51:03 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id BA50CA55C47;
 Wed, 13 Aug 2025 12:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B4EC4CEF6;
 Wed, 13 Aug 2025 12:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1755089452;
 bh=1sFEp7tfTZsLqsEbQ6yN/DfqybrcqHWTfRSt7pluUnU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=G/lvod9qaNFe8MgiqMNtSrnZl6ICr4ny7PsTyyOhzVZeCv/MZyhfDLlgNxCv37Z7r
 GYSIKBF/pteVt/vjuJB94/MdSefsCgRAQaRxWEIW2/awDVXuZZFSfXB+5rMnnQexLI
 cxOX0SSrpyCPB+x6DMMiVzgiv5VergRxG6Bl2MhE=
Date: Wed, 13 Aug 2025 14:50:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Ben Copeland <benjamin.copeland@linaro.org>,
 LTP List <ltp@lists.linux.it>, chrubis <chrubis@suse.cz>,
 Petr Vorel <pvorel@suse.cz>, Ian Rogers <irogers@google.com>,
 linux-perf-users@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>,
 Joseph Qi <jiangqi903@gmail.com>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 6.16 000/627] 6.16.1-rc1 review
Message-ID: <2025081300-frown-sketch-f5bd@gregkh>
References: <20250812173419.303046420@linuxfoundation.org>
 <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
Received-SPF: pass client-ip=147.75.193.91;
 envelope-from=gregkh@linuxfoundation.org; helo=nyc.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Aug 13, 2025 at 05:46:26PM +0530, Naresh Kamboju wrote:
> Long story:
> 1)
> The perf gcc-13 build failed on x86_64 and i386.
> 
> Build regression: qemu-arm64 ARM64_64K_PAGES ltp syscalls swap fsync
> fallocate failed.
> 
> > Ian Rogers <irogers@google.com>
> >     perf topdown: Use attribute to see an event is a topdown metic or slots
> 
> Build error:
> 
> arch/x86/tests/topdown.c: In function 'event_cb':
> arch/x86/tests/topdown.c:53:25: error: implicit declaration of
> function 'pr_debug' [-Werror=implicit-function-declaration]
>    53 |                         pr_debug("Broken topdown information
> for '%s'\n", evsel__name(evsel));
>       |                         ^~~~~~~~
> cc1: all warnings being treated as errors

Already fixed.

> 2)
> 
> The following list of LTP syscalls failure noticed on qemu-arm64 with
> stable-rc 6.16.1-rc1 with CONFIG_ARM64_64K_PAGES=y build configuration.
> 
> Most failures report ENOSPC (28) or mkswap errors, which may be related
> to disk space handling in the 64K page configuration on qemu-arm64.
> 
> The issue is reproducible on multiple runs.
> 
> * qemu-arm64, ltp-syscalls - 64K page size test failures list,
> 
>   - fallocate04
>   - fallocate05
>   - fdatasync03
>   - fsync01
>   - fsync04
>   - ioctl_fiemap01
>   - swapoff01
>   - swapoff02
>   - swapon01
>   - swapon02
>   - swapon03
>   - sync01
>   - sync_file_range02
>   - syncfs01
> 
> Reproducibility:
>  - 64K config above listed test fails
>  - 4K config above listed test pass.
> 
> Regression Analysis:
> - New regression? yes

Regression from 6.16?  Or just from 6.15.y?

> 3)
> 
> Test regression: stable-rc 6.16.1-rc1 WARNING fs jbd2 transaction.c
> start_this_handle
> 
> Kernel warning noticed on this stable-rc 6.16.1-rc1 this regression was
> reported last month on the Linux next,
> 
> - https://lore.kernel.org/all/CA+G9fYsyYQ3ZL4xaSg1-Tt5Evto7Zd+hgNWZEa9cQLbahA1+xg@mail.gmail.com/

Ok, no real regression here if this was already in 6.16.

Doesn't look like it got fixed in 6.17-rc1 either :(

thanks,

greg k-h

