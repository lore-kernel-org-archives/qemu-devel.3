Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416C3C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 09:43:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu5UC-0006PQ-Na; Wed, 12 Aug 2026 05:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1wu5U5-0006OA-O3
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 05:42:57 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1wu5U4-0005Fl-07
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 05:42:53 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c15d47266baso82415066b.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 02:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786527770; x=1787132570; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6zcC3Cy4jEKlMbqYCi+jW9CSJ0w7jHPrhFkPwYC/9rg=;
 b=HvcmCLei6HP2uqaDhl5ZgW22BIFD0zJHvXZXBxbGkA1jugIREuTyVxgy2uSXpvo7sD
 gy+JLOf3yni8C7clEhAlzT5gtfWJQ8C6Cm+xoMsW7adwDuzVSTiqHS2Z7Q2CjL+4mM1o
 H197wHvGLW9MP7qT2/5njjM6KRCaf14DTRvVbvYqKCi2UU9J1zJZTR2NLHDcPBpxvsT5
 KMCJYasnBrK6TbJq0XsYYJcqI01NVfF1ynalv2iCdKbimcyU+s6QRSTJ2Ao8FNO5pf48
 c2wFqOH7zZcTeBeCuKsny4V2/0WJpEwsPQgeAJuX/hdcXi/5Pz7j/olVZN0WhGGyCTMK
 gfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786527770; x=1787132570;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6zcC3Cy4jEKlMbqYCi+jW9CSJ0w7jHPrhFkPwYC/9rg=;
 b=HCPQeyB+SudV+E58vsDMgCWkPtiDMjhGCkv7sIvT0pGy5c/1OENe6NCq+yO6nwuKgG
 IaeLgpY9b3RzLBQc2Xb9m4CLCEnrjqSLC5tUN3WRgG0dPqPNgPtKIMwnUYMgfSkDg9fE
 YI5hwBXbwJqmbhHkIPWChjx+2tx3fVKVBlKguqS6ZB3r8Ed1Ni0400CE79dBP6cs305R
 KyphR/NjoLrf/OxMJcYKX2NXj8Vyoyj5INVTEgAQCXMDR5uVGIutiYWi6eMiFFDO9Ur2
 Gs9kOV5D5KbN4p+QYQjnhXofeqT20sZ5iDJHYO4lIty9mq8oxF25K3ogNvbroefpPfGu
 6a2w==
X-Gm-Message-State: AOJu0YwcJ0TDSefnj9cnuU76Yn8NjhSiaVwIDgAb42LxV7EWPMpNCAKz
 jzbH29abXqlPXuTTeVnut5dH5mpI6PKUGP4zH11GBM+RQrvmfGHVq2V8v1BtsmAc8bM=
X-Gm-Gg: AR+sD1210UUoT/TWQNIqhVjmd56wk6vrJbcn47BRmR175S2Mu9LYbeCb/TW9LyIrCGj
 pmoANvUFxGViVRJJUUG11gLZckviIlD/FpDK1EPT9gepADjZTokXenUjS0yyPgoUuh6v7VzpPno
 m8kqexkEoczPqCD/OxfkoNiZskGGim8cvrjpumwwMCxYnhBzDtlnPyzgBLuWY2HzGAXziglgEQq
 3Z2pTiWyeVnY+TXZFm71waRVn/22/4Vl4rxADAp3d8nyGCrDF6i6YdBXzSCihompw6T6pC8xolS
 NTBL4NskASaEpYn/FMlDDFYqN3Ey9GLhlBxWxeAp4cua733mlHvwUE0QMYtIhvTBrxXlOv0Is6x
 ZkyKnQitEkebwZFzxrKXn6PJdSUagi+gaEEv2A61eClenZJoRYyLwWR2MvIdVXowv/KPGg1r4DK
 ic4drVe6fUNQFAc3VZLcIEedx/dOajvad4a5SUymffB9NRf+11HgY2UB1QllWe2qioEHmMbScbz
 CJ8uuOlPjnm6cLF8/FMPgtZ58EIiJ8Hf4PPYetMM84hwueb9LgCW2MobaYjw2Y=
X-Received: by 2002:a17:907:3f8b:b0:c1c:4895:c3ba with SMTP id
 a640c23a62f3a-c20f304ebfcmr156234266b.22.1786527769550; 
 Wed, 12 Aug 2026 02:42:49 -0700 (PDT)
Received: from tulp
 (2001-1c02-1a15-3000-ee82-4536-a8f2-9e22.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:ee82:4536:a8f2:9e22])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3768917d0sm472513a12.3.2026.08.12.02.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 02:42:48 -0700 (PDT)
Date: Wed, 12 Aug 2026 11:42:37 +0200
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v3] qga: implement 'guest-get-fsinfo' for FreeBSD
Message-ID: <anxADf6QF3lqzLLw@tulp>
References: <20260714165759.7521-1-bogorodskiy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714165759.7521-1-bogorodskiy@gmail.com>
User-Agent: Mutt/2.2.16 (2025-11-22)
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

  Roman Bogorodskiy wrote:

> Implement the qmp_guest_get_fsinfo() API for FreeBSD.
> To implement it, reuse build_fs_mount_list() which is already
> implemented for FreeBSD. Extend the FsMount type to include
> a string "fromname" attribute to store the disk the FS is mounted from.
> 
> Disk mapping info is not covered by this implementation.
> 
> Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> ---
> Changes since v1:
> 
>  - Replace g_malloc0() with g_new0(.., 1) for GuestFilesystemInfo
> 
> Changes since v2:
> 
>  - Drop the unused 'errp' argument to build_guest_fsinfo() and
>    clean up the related code.
>  - Fix leaking string through g_strdup() for a g_path_get_basename()
>    allocated string.
> 
>  qga/commands-bsd.c    | 53 ++++++++++++++++++++++++++++++++++++++++++-
>  qga/commands-common.h |  1 +
>  qga/commands-posix.c  |  3 +++
>  qga/qapi-schema.json  | 12 +++++-----
>  4 files changed, 62 insertions(+), 7 deletions(-)

ping

https://patchew.org/QEMU/20260714165759.7521-1-bogorodskiy@gmail.com/

