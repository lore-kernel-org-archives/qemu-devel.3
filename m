Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A624C88E50
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 05:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5zRA-00056z-Ts; Mon, 14 Sep 2026 01:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isyanfei.xu@gmail.com>)
 id 1x5zR8-00056i-Ak
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 01:41:02 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <isyanfei.xu@gmail.com>)
 id 1x5zR6-0004nr-Lo
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 01:41:02 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2dcff8f44f2so43199285ad.1
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 22:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789364459; x=1789969259; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vNdQChrXo0jKvGI0f2tl5QXuW3KcYD48RhM27t/eTto=;
 b=Bg9376Pz5fFB2X3hEEKWC6AdUfYzBGVh4uEWnPb+YscIcdp4/6IHfl7vEwDmCrI3oc
 NhLZaW+dTnnHrOP3IXRsCP9L/OQu28OfYPGEfOLSlkaxb99vkmuxt0+/ja7z1Td3UooP
 XHfv6JJVqiDfnn3pBjkSCpzgpaoW+jTVqORxDOifFwrIqh0RwP8eff06r7/4TwuPD4nV
 7MpNjZimfXO/aJH9ENLFQLY78/V0vyhoK1uHanm5prOdyzV8c5Z0v29b0dRB0u2P4H04
 21i+7u5LKcUuwoR1/HK4kjfduE9lSDWblw2DHqbinqRxLffaRpmGKg3R7YuEt+5413gg
 jvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789364459; x=1789969259;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vNdQChrXo0jKvGI0f2tl5QXuW3KcYD48RhM27t/eTto=;
 b=pfNHXNTpG+zYRZHcrmT9nn39ag4Be1yZuSAxTFnh8d1p/o8nqREfkv2JFTD1ldZkcU
 qxZvFB/4UDWssaaTZ1q0lI8paXQeNtLb0pF/psOEYbTVtV6UqIlrYb0h2qagoSFY69nD
 GGOoRbbMZvJewdOv9aKewV2t+h8bEtbpIBvXgyFEX2ieVtj7NfPYWAj+qK73c1Bw2t1T
 0roOVpNwe9wh/6bQdgRWEoiSwc39dXo5x9kRfK1NRCqqqexh8kbbu2twczjq/YCA9ese
 4AtrUjrAYNVRDfsXeGfiwbwB9UrubAXn4D6wJ0FvEJj4OgOwGBlASFeurtUTEu8v2lHx
 99fA==
X-Gm-Message-State: AFuF++kYxcmTPG1tm2wfQ4eWdGRDs17JBp5IWQW+xNEgNnEXpQIR1IZ4
 czy4QrnF1fl38yJa36uY7jDbFsLsUZxhYbH9Tnh7J5LUJezXK5Pl/+3k
X-Gm-Gg: AYBFou0KHQPOQXkMngrQwJlyGbsCXM/pS92r8lYpBPNmBBZru+vPp0AjescP1r/dyXH
 SVlU7M/CS1Y6vGX2O2vINCmWgUhVa0u3JtIG7UKu4Q0WK5wwJDkaFSKmisDVl65ULfLlcs4nksv
 uM5pFQhMZPh7ytoa2aUpx1pwIMAjFjZmIZvaLDHHuGQ+UyYYozy82qqc7h+jsWPq1JxZ0EnVug/
 MAgKsb50PyyExAQ1lotmJaVXKk6p0t1eqM3C9P2dKx8i7FWmm17Efe4b1IuvfHoDNgOsyH4YAvA
 GcQ4x6EB1aJ+2TLm4RTHcEF+mghe6YZ7SU13tYmBiTGzDYVFkepZxJjYvK3Y0IjLS6ha5HfOAYQ
 y4sOK3CrymaH8E9WSsurkUhbZNyHZUnzKPXAPeTj11u8CchvqBcDLowxZHWDImJZmgqZpDLY/kf
 UctKrNDTyUNjJwtR/4NjONfOrjUtIaR1Ft2/CwbuMj1A+OQY6hfaMgJyCrINwFlYQhP38cWBjA2
 kWogI+pnZ1oQ2QBajA=
X-Received: by 2002:a17:902:e744:b0:2bf:dd0:c8b1 with SMTP id
 d9443c01a7336-2dd6c4835d0mr23828155ad.0.1789364458772; 
 Sun, 13 Sep 2026 22:40:58 -0700 (PDT)
Received: from [10.255.206.241] ([139.177.225.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd6f8ebbdfsm1669795ad.38.2026.09.13.22.40.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2026 22:40:57 -0700 (PDT)
Message-ID: <7d0c9385-e278-4361-88b6-55971731fb87@gmail.com>
Date: Mon, 14 Sep 2026 13:40:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] migration/rdma: Allow multiple writes per chunk
To: Jinpu Wang <jinpu.wang@cloud.ionos.com>,
 Yanfei Xu <yanfei.xu@bytedance.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de,
 lizhijian@fujitsu.com, fangying.tommy@bytedance.com,
 caixiangfeng@bytedance.com
References: <20260913062455.940447-1-yanfei.xu@bytedance.com>
 <CAMGffEmorCT_swNfGqZJvHyfYk7pZBPier-qu3NaFjXf-sE8vA@mail.gmail.com>
From: Yanfei Xu <isyanfei.xu@gmail.com>
In-Reply-To: <CAMGffEmorCT_swNfGqZJvHyfYk7pZBPier-qu3NaFjXf-sE8vA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=isyanfei.xu@gmail.com; helo=mail-pl1-x62f.google.com
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



On 2026/9/14 13:04, Jinpu Wang wrote:
> Hi Yanfei,
> 
> FYI, I ran a quick migration test on our test machines and didn't
> notice any issues with the v2 patchset. We saw a 10–12% downtime
> reduction on our setup (100 Gb/s dual-port IB fabric, 100 GB VM, idle
> load).
> 
> As v3 don't change the implementation.
> Tested-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Thanks Jinpu!

Yanfei

> 
> Best regards,
> Jinpu Wang


