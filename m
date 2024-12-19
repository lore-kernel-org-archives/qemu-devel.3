Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D7EE7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 20:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tONKd-0000pb-LB; Thu, 19 Dec 2024 15:41:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan.carpenter@linaro.org>)
 id 1tOIap-0003Ua-1N
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:37:39 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dan.carpenter@linaro.org>)
 id 1tOIan-0004Dy-0x
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:37:38 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aabbb507998so173352466b.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 07:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734622655; x=1735227455; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PUel+go/CfHo5w+Jm9alc/L9kT7jqDV+xMlQDoVR8Gw=;
 b=j7YIYwIxclGFVJs2FAsqKO1Xmpm2HGx+gCZcuSQBOlE1/z9VJ7K/f8JrOjJYG29EqF
 bQWBv8d8n4mvOwTPP+wSmF2ljxng7TiW/GfGK9D91Ir0TyfNy0PeSc+VO2rohQ4ACRIl
 XW1vWYaU/zM9uxDYkT+be4drL+HrbKSkuxLSiAaJhlw22kQ8DYSSC6+eypmXr2uAOzK3
 WlAG3sp/RizXh/2QQvhSK8KmPtE1jjmU70VZXFIzfhj+NL55G1Nh5i+xZQ3j8r1t00Ne
 Kpr5vhAQEEoty2Hca9Ypso/A3iw9JY7/QVuQEhAVNKF2vXLhh6ii7dahibPpPm7nJQpS
 wDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734622655; x=1735227455;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PUel+go/CfHo5w+Jm9alc/L9kT7jqDV+xMlQDoVR8Gw=;
 b=KE8F574iIahbMWFPewidpoz7OwpgmQFe1MmC4oazj8gC4ZcGkEzx/s/sXKevZMg1bK
 rDSxMkrjaSDUwPOehBl9T0Gt9dnd9S5P5WP52l4/d2C3k4GspsnSAG9XAT/GhRSsIoDN
 J5ieAkNG6858mEq59Tph4dbbd6Xtw6V84U2q2tUP0dpyv9624qyl+FcvP7ilHoop907L
 zMDSAxHRvpHsypMN7pAb8XN4kQM2YME9rfCVIKGZC5v6bcqagIi4gU6Nmqho9fv8JAgd
 dhssrUc3S5VvDxefagdQXn7GiNsvw3YsgnQThzCx4AtHIfAkn3iRw/La1TvZEugSJxMf
 kqWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaTLLQX2VVRwBbU2qu9DqEP46KFN9EQGO/sA87cjXA4hmbpxiEztgnAECz3hDOwJxBEYVoJkK1d5/F@nongnu.org
X-Gm-Message-State: AOJu0YzEowet+JrQKjkPX6xkJUXSw0ayNmgg6smpfzlOruEnPlUQz3eS
 RWTj6gIU4EmXs0fxPgnWqhdJgG3qvbj9dj0xWp+U1of3MXQpZnMPJrHwJwgqi8Q=
X-Gm-Gg: ASbGncvhDnO8qPfjeHK1066xcCJQ2TKiwGZIZOk0QTk1GjA8l5L6asNTIjOnUv9xnMx
 eBEbCFtYqlZqnPDl9RbZPMKmCaEbfKlqnsJQo7WVffztkPTu4WlaOqlgRe7x4a9RqSpVxKdERvJ
 GXpqklFID3t20SDN0ztrNu8VYRvB3wFXH7Wox+K4hCakiGpUNnmjUtTFM/RKnYJ9ATR8T26MDIz
 tGnglvf0vBQTr7v28Ajh/u0BBNIADcKLFC/pBozuKq67zd1BhLHca5bwBEHBQ==
X-Google-Smtp-Source: AGHT+IGOfjBlXmb85ooSC48O2PP6uDSwvgb94XqQqZFbgj/syi0wA374X0g0G+01L7MUNMWSd0nROw==
X-Received: by 2002:a17:906:328a:b0:aa6:800a:1291 with SMTP id
 a640c23a62f3a-aabf470a0b4mr637938366b.7.1734622655089; 
 Thu, 19 Dec 2024 07:37:35 -0800 (PST)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0eae74e4sm76965466b.91.2024.12.19.07.37.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 07:37:34 -0800 (PST)
Date: Thu, 19 Dec 2024 18:37:30 +0300
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
Message-ID: <0c46224b-ed2b-4c8e-aa96-d8f657f59b9f@stanley.mountain>
References: <CA+G9fYvf0YQw4EY4gsHdQ1gCtSgQLPYo8RGnkbo=_XnAe7ORhw@mail.gmail.com>
 <CA+G9fYv7_fMKOxA8DB8aUnsDjQ9TX8OQtHVRcRQkFGqdD0vjNQ@mail.gmail.com>
 <ac1e1168-d3af-43c5-9df7-4ef5a1dbd698@gmx.com>
 <feecfdc2-4df6-47cf-8f96-5044858dc881@gmx.com>
 <a3406049-7ab5-45b9-80bf-46f73ef73a4f@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3406049-7ab5-45b9-80bf-46f73ef73a4f@stanley.mountain>
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=dan.carpenter@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 19 Dec 2024 15:41:15 -0500
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

On Thu, Dec 19, 2024 at 06:10:56PM +0300, Dan Carpenter wrote:
> > > Mind to test it with KASAN enabled?
> > 
> 
> Anders is going to try that later and report back.
> 

Anders ran it and emailed me.  I was going to tell him to respond to
the thread but I decided to steal the credit.  #GreatArtists

 BTRFS info (device loop0): using crc32c (crc32c-arm64) checksum algorithm
 ==================================================================
 BUG: KASAN: slab-out-of-bounds in __bitmap_set+0xf8/0x100
 Read of size 8 at addr fff0000020e4a3c8 by task chdir01/479
 
 CPU: 1 UID: 0 PID: 479 Comm: chdir01 Not tainted 6.13.0-rc3-next-20241218 #1
 Hardware name: linux,dummy-virt (DT)
 Call trace:
  show_stack+0x20/0x38 (C)
  dump_stack_lvl+0x8c/0xd0
  print_report+0x118/0x5e0
  kasan_report+0xb4/0x100
  __asan_report_load8_noabort+0x20/0x30
  __bitmap_set+0xf8/0x100
  btrfs_subpage_set_uptodate+0xd8/0x1d0 [btrfs]
  set_extent_buffer_uptodate+0x1ac/0x288 [btrfs]
  __alloc_dummy_extent_buffer+0x2cc/0x488 [btrfs]
  alloc_dummy_extent_buffer+0x4c/0x78 [btrfs]
  btrfs_check_system_chunk_array+0x30/0x308 [btrfs]
  btrfs_validate_super+0x7e8/0xd40 [btrfs]
  open_ctree+0x958/0x3c98 [btrfs]
  btrfs_get_tree+0xce4/0x13d8 [btrfs]
  vfs_get_tree+0x7c/0x290
  fc_mount+0x20/0xa8
  btrfs_get_tree+0x72c/0x13d8 [btrfs]
  vfs_get_tree+0x7c/0x290
  path_mount+0x748/0x1518
  __arm64_sys_mount+0x234/0x4f8
  invoke_syscall.constprop.0+0x78/0x1f0
  do_el0_svc+0xcc/0x1d8
  el0_svc+0x38/0xa8
  el0t_64_sync_handler+0x10c/0x138
  el0t_64_sync+0x198/0x1a0

Here are the full logs.
https://people.linaro.org/~anders.roxell/next-20241218-issue-arm64-64k+kasan/

regards,
dan carpenter

