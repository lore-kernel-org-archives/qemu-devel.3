Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDC3E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 20:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tONKe-0000pq-Tq; Thu, 19 Dec 2024 15:41:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan.carpenter@linaro.org>)
 id 1tOIB5-0007Ja-VE
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:11:03 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dan.carpenter@linaro.org>)
 id 1tOIB4-0007w3-Ex
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:11:03 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aa6aad76beeso133722366b.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 07:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734621060; x=1735225860; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=a8c0Ewl7BQkquEtJaiXqSJPyhaxk2Iz2kiqNEhnfoII=;
 b=tUz1u1gDrViBOUryTe0JqZpJq7x2YCoWcYM5z/f090l5qkQ/vm400Dcfygg39/5kEN
 LB5DVz0j6/9sjCSCudwFwjhNYYmnynC0CWWub65eSNxx0pgsG5APVYXP4J8O9/ExRTuN
 bgIUwdeZiLxSMQccxs3h+G2FcjC8ddA8w4sE9tka+wZbvIkY6U2yZqrzOe3/ptVHr6BG
 qb+sTebMnzyFx5DMHk6aIY37ydZCFILKWzBJQs3sg2pIJjbcMb4R/FfF0zDbgz02gwRI
 m8pNfRPPUl93dHaInBUPF7AxtRClHYxBivs15nwVmTquEzN2vaaOLslvFRBTC/3silxI
 zwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734621060; x=1735225860;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a8c0Ewl7BQkquEtJaiXqSJPyhaxk2Iz2kiqNEhnfoII=;
 b=Bd9f9+tREQkuprTFPGOmY8UMRZsIPFsNpGEjg0myYWwO2BzL91BnkUoVUoop2I7NdV
 oJ5y5TBW1ZPJiin91MgzvfMCvUuMrnoFA293L6T6HoH5ObBD0PNllVlNht7ZhvJyBOBz
 IxM7RziCmBuNs9bxtNn3XYEvl0CmK2HWA6UR3G3pFnf/A+jVLnHC2fKm5w2GIisln1Qo
 XHRtcduZp7RMDc17Qy+frEX2PBk2sGZ+ejtlrLM54N75IvPBE5LVwiLDeUthakv7Ky1d
 Moxo1DiP+bDzdLrD1e0jnbYgdlvEzCycmbzsHxZyy9V2a1Q6R7PefLKpg2/J9ZCQOIX8
 XXIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrWdZfDuEGz370pnZUpQpCcK8Z7dAE784uD6uEdDVI8l3jXqT8//p66pjYjSDdNFsynGpqeXXEnV9B@nongnu.org
X-Gm-Message-State: AOJu0YzsuL2pUqtk10nRC0l1gkjDY+/3NLq/up/TpcJoJuxgCC+XaEIq
 h2BEjT98mkU71bcx2RuiMiCAdsvdiZ33VY41LYH1Wc8tzi6qdEr0O9JJKI5xoK0=
X-Gm-Gg: ASbGncv5JpEJ5YLIS1MQe8GjQGwIEpWNec0ZdeZqhqYAy7uoP2b9Tml1yE+LaKnr05G
 iDsFO82gLhnFWjfdgFXfQgmbWahOHdPjIZ6L7LxYeiGe2gGFpIKH2xWEOQnGboU74g5Q46Wv4zt
 mi90MOmoswQ3WuUmbHsyTFmqsOVjeQu3Xi5eCwy5ppHj5fBVp7V4Xl0x4VkSxg6GMfMVH+173rj
 rfeNwF/nP8MfwUpRym79UWXyxxi8XIwCY4195kAgIEWpWbdaA+vB+mDg25Dtg==
X-Google-Smtp-Source: AGHT+IEpIUPQqVgupeRzlOrpnAifiL/wITich3F10TXkppCOZb1lR3IE5oC8DUkcXCbnI2ox83X/9w==
X-Received: by 2002:a17:906:3092:b0:aa6:b5e0:8c59 with SMTP id
 a640c23a62f3a-aabf47f6a50mr576895266b.35.1734621060458; 
 Thu, 19 Dec 2024 07:11:00 -0800 (PST)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e8301bdsm74864266b.31.2024.12.19.07.10.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 07:10:59 -0800 (PST)
Date: Thu, 19 Dec 2024 18:10:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, qemu-devel@nongnu.org,
 open list <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 linux-ext4 <linux-ext4@vger.kernel.org>,
 lkft-triage@lists.linaro.org, linux-mm <linux-mm@kvack.org>,
 Linux btrfs <linux-btrfs@vger.kernel.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, Qu Wenruo <wqu@suse.com>,
 David Sterba <dsterba@suse.com>
Subject: Re: qemu-arm64: CONFIG_ARM64_64K_PAGES=y kernel crash on qemu-arm64
 with Linux next-20241210 and above
Message-ID: <a3406049-7ab5-45b9-80bf-46f73ef73a4f@stanley.mountain>
References: <CA+G9fYvf0YQw4EY4gsHdQ1gCtSgQLPYo8RGnkbo=_XnAe7ORhw@mail.gmail.com>
 <CA+G9fYv7_fMKOxA8DB8aUnsDjQ9TX8OQtHVRcRQkFGqdD0vjNQ@mail.gmail.com>
 <ac1e1168-d3af-43c5-9df7-4ef5a1dbd698@gmx.com>
 <feecfdc2-4df6-47cf-8f96-5044858dc881@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <feecfdc2-4df6-47cf-8f96-5044858dc881@gmx.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=dan.carpenter@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 19 Dec 2024 15:41:13 -0500
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

On Thu, Dec 19, 2024 at 10:44:12AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/12/19 06:37, Qu Wenruo 写道:
> > 
> > 
> > 在 2024/12/19 02:22, Naresh Kamboju 写道:
> > > On Wed, 18 Dec 2024 at 17:33, Naresh Kamboju
> > > <naresh.kamboju@linaro.org> wrote:
> > > > 
> > > > The following kernel crash noticed on qemu-arm64 while running the
> > > > Linux next-20241210 tag (to next-20241218) kernel built with
> > > >   - CONFIG_ARM64_64K_PAGES=y
> > > >   - CONFIG_ARM64_16K_PAGES=y
> > > > and running LTP smoke tests.
> > > > 
> > > > First seen on Linux next-20241210.
> > > >    Good: next-20241209
> > > >    Bad:  next-20241210 and next-20241218
> > > > 
> > > > qemu-arm64: 9.1.2
> > > > 
> > > > Anyone noticed this ?
> > > > 
> > > 
> > > Anders bisected this reported regression and found,
> > > # first bad commit:
> > >    [9c1d66793b6faa00106ae4c866359578bfc012d2]
> > >    btrfs: validate system chunk array at btrfs_validate_super()
> > 
> > Weird, I run daily fstests with 64K page sized aarch64 VM.
> > 
> > But never hit a crash on this.
> > 
> > And the original crash call trace only points back to ext4, not btrfs.
> > 

Yeah.  But it's in the memory allocator so it looks like memory
corruption.  After the ext4 crash then random other stuff starts
crashing as well when it allocates memory.

> > Mind to test it with KASAN enabled?
> 

Anders is going to try that later and report back.

> Another thing is, how do you enable both 16K and 64K page size at the
> same time?
> 
> The Kconfig should only select one page size IIRC.

Right.  We tested 4k, 16k and 64k.  4k pages worked.

> 
> And for the bisection, does it focus on the test failure or the crash?
> 

The crash.

regards,
dan carpenter


