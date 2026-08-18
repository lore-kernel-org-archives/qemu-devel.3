Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC3AC5DF7E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwIRR-0003rP-9X; Tue, 18 Aug 2026 07:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isyanfei.xu@gmail.com>)
 id 1wwIRP-0003rE-4a
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:57:15 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <isyanfei.xu@gmail.com>)
 id 1wwIRN-0005pa-Kc
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:57:14 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-383b4a3755fso4583811a91.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 04:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787054231; x=1787659031; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8Wq3bqUup6IVfUtfr6kOhyNDKiUer6obVouPp442DW8=;
 b=iS7n567lzv7LjMkyMdtE/2mvu5EfyujLfKrd/y4uMfqWlM1EIS47BncawUF/Gm2h84
 d9C7QvkFPQigacNk1BDubjkDTj7vsCZ67B7VoX3l1Mzu32ludZBbdGb0VbUJKmyHT/6i
 RdhMF0KsmOAROBKRi2dFX5ui2L5QJF5uJhaGrGPtu7/DuuGBxPIHh2deVPsdXYPozeNC
 h8JfnHqJNKQLlv5nyRsG8h66JE1hYD91T4yaesnRh3sxxpNI03VEwncJ5FTpKa8Edrg3
 wFvU4FwulWhK6XJtS+0zNCtn1h+TCSYuZgl9340xIy95+lHJk6zIhyZQ+Kl89jJiz5Sv
 rtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787054231; x=1787659031;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8Wq3bqUup6IVfUtfr6kOhyNDKiUer6obVouPp442DW8=;
 b=R4Rzu61BbO9UDHelRkjSkGIoMuSCH9tQy9aNvUbXJx6AE1LwVqwBQaYKRzqSnA5ceI
 iasbx92gCXXvSUiTK/SIVsnvaWwx/UvGMTnVQJuhy5WV4wIUcJCggDBUud50US4sIKx7
 o3i39palt0uhkrF+qLtZnXUzIbsGNDEJeQ8ilsS2EmvyzPeJMIa702aTFvBOSHMCr/0x
 TPMtCuE6YBOjME2JhbVJLDFzj0RJZW+nhZ/vqK+/nawYVUX6G6GoqIw0gljYC0vR9Rgv
 RMOEBNx/CaCDc8YelNcZTOf1NcddJ9vZpFKeo58zf1h986zCThzFxHQUWlHXqUM9gXoL
 XUjQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpnDdC6QC0K5S4QrXJ/GF/tXcN10SloeQl8tgwXtG2sstWu/fvnKOA4035sSGh+OIgVhcL3BXEYi4ib@nongnu.org
X-Gm-Message-State: AOJu0Yx0tXqT8yoL2xws9ZjuzzBBMX4NT+kU1sSswwrJbZOKfb3DYVXi
 zdyyCdwxSVj4UFDBPg6cWuy4gkYRCdCWu54sdcYVZ4/PQb7NQC/ZA/0T
X-Gm-Gg: AR+sD11JXjqBaRWXyLQz6huO9Zgf2aup8qvhAPoSAMU2rpFTzU5JQS+cyxPs4oX3Krh
 g+nWZI8nmHCAVLdkG+AHJYta6pcevGSBXX4K9RcrXG+nhpjHj5OK5vdUV53piInV8gceMTaIaFz
 8EnvxgZZ3zoj5LvZhyE15R5aj0tz/nW5Q0mLk92ISA/PKyXY1gn4AtIi1jvXmIUS56KtMKZf7om
 +cKPR5aMWaYxai8BWTTq+Yb39KdsyvKpqq+qAI1y5L396aQR1cnWvVRaOdwnJ1nhKNl1H/iqWok
 bxVaXKPub/FGiPSu91bKjFPJzjlckjs52vSQ0iKC3osiHlPZQlZoLhmzPg5NUfg18baZj3H3db/
 G9dvdZLo5zcgqgqTO7ssuBWFqC89gnljY2jz8Wh2iWL7eY3D2pAznvVeQLRvT3fDZHanv0CAJIu
 vDMlrbPQ/rPbCiEKdRFOTdc4t4jbEcU9gLtLrErN8hEhG1P+nzdooKNl4aUm9GH3T2ZcUL9SLTN
 S1g4Pot6noP
X-Received: by 2002:a17:90a:ec83:b0:381:e74f:8a6a with SMTP id
 98e67ed59e1d1-3933b8c1041mr36796374a91.16.1787054231140; 
 Tue, 18 Aug 2026 04:57:11 -0700 (PDT)
Received: from [10.3.188.167] ([61.213.176.9])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39531e84244sm8670836a91.6.2026.08.18.04.57.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 04:57:10 -0700 (PDT)
Message-ID: <4d0d08d3-ad6e-4de3-85b8-587b70286b04@gmail.com>
Date: Tue, 18 Aug 2026 19:57:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] migration/rdma: Remove unregister code
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>, Samuel Zhang <guoqing.zhang@amd.com>, 
 Fabiano Rosas <farosas@suse.de>, Jack Wang <jinpu.wang@ionos.com>,
 Juraj Marcin <jmarcin@redhat.com>, Yanfei Xu <yanfei.xu@bytedance.com>
References: <20260817202424.2901438-1-peterx@redhat.com>
 <20260817202424.2901438-3-peterx@redhat.com>
From: Yanfei Xu <isyanfei.xu@gmail.com>
In-Reply-To: <20260817202424.2901438-3-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=isyanfei.xu@gmail.com; helo=mail-pj1-x1034.google.com
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

Hi Peter,

No objection to removing the dead code — it clearly never worked

I do have one question about the direction, though. The removed logic
was the only in-tree attempt at MR unregistration for the non-pin-all
path. Without it, registered MRs grow monotonically over a migration,
and with large, widely-spread dirty memory over chunks the accumulated
MR metadata (user + kernel) can cost more than pin-all and even perform
worse — which rather defeats the purpose of not pinning everything.

do we still intend to keep and improve the non-pin-all path going
forward? If so, some form of dynamic MR unregistration will eventually
be needed and it might be worth keeping this code，or at least leaving
a TODO to mark the gap?

Thanks,
Yanfei

On 2026/8/18 04:24, Peter Xu wrote:
> The unregister code was there since the first commit RDMA migration was
> merged, but it was never functioning.  Remove the dead code.
>
> Since the two control messages are the last ones, we don't even need to
> worry about compatibility of legacy RDMA control commands, we can directly
> remove the messages too.
>
> As a side effect, this patch closes a report by removing the code
> completely.
>
> Reported-by: Tristan (@TristanInSec)
> Closes:https://gitlab.com/qemu-project/qemu/-/work_items/4003
> Signed-off-by: Peter Xu<peterx@redhat.com>

