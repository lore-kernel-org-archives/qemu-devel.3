Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2865F53D78
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 17:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2BHl-0007sU-89; Mon, 16 Mar 2026 12:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w2BHh-0007rY-1H
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 12:59:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w2BHb-0001kv-K5
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 12:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773680349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jJwE8FcpWd862qoa3YE4LKMayWc9IAG7l/gQK0A/y0k=;
 b=SPCOd/y7t6ZzptBsmTy+8ydFARK/lw+6h+ybhBnPyfVtk6c/sdNAOI55lAdSxeNLcF38/Y
 iSg/PGXITQ8oJCvK2RJrVXm6MhSJyUGcDfxtu7klcIf7dJZuvDMgyeGqje1LqhjoU5EpbJ
 JoeOxiu8aUqMEkTHQU0blWoqMJ33PcQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-lhxgc3eUNMGqj6C3cOmJuw-1; Mon, 16 Mar 2026 12:59:07 -0400
X-MC-Unique: lhxgc3eUNMGqj6C3cOmJuw-1
X-Mimecast-MFC-AGG-ID: lhxgc3eUNMGqj6C3cOmJuw_1773680346
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-485345e2fdfso26241235e9.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 09:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773680346; x=1774285146; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jJwE8FcpWd862qoa3YE4LKMayWc9IAG7l/gQK0A/y0k=;
 b=jEcWA5ViEKr3Y/PSwj4iZGjBT+d9lwWuoNSNCSL4r5YTSn55ITi8YqJbEX8ZvVl1oC
 yROJ+SsVw2m6nw2xcdbT+tsxzkHQt7Sd6+TRbr0GUDKyhxC74XR/9+coKVOTduo8d/BR
 PZ0HKIhEY3bXojiDp6U3Bo13FkB+MI5SxOV4zBjHEKHFGl9GJ/ypsyByXYQ1MEb9mBGu
 eGejHoaNBj2u2ZApynhOKNCZW4aEBW+9N+BNHWfjh48t/HJEiCjpy3BpO8plyswmhGqs
 urkbNHkpOPTulYQMXXQCGu/u6fq4SAUYWg95H0WSODm+1QyjzKxVePSutDnr+irbnL17
 pPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773680346; x=1774285146;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jJwE8FcpWd862qoa3YE4LKMayWc9IAG7l/gQK0A/y0k=;
 b=DR4sSVespJ1F+s3RJRr2ItuXLuJNVCM9F1mO5DFIdFQdZADBw0Tx0qStGvQU4/x+rk
 FJDUdbq8DevCkmamnh5xnpGmMMgKSBeYLs1OOn7FHiuOyqcre21qXPhwldmfVHAb7ZYN
 8LPkjx16v+5T8zKfUZVcSo23nuXUzquuMWRLh8w3SRD79fph5b8xCdw2lZ20Um7NE3Lz
 krBe/CLkVB7Giko6rtIn4z+QAMgF5AxSLPL3Yz68aenut88O4eEqW82c9bYa6EfzPu3L
 DRjnIsUJ2gGn/GtH3T1UzuMtZwo5JYHcEPM5LAiIXQZ90p0h+0C7NJmO5LaixC+TBWp7
 h7Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsCOc+ibvMBdN7l9Nld+S0ZJwQMSVKbcce/52r89nROuRjTZQU0OZouDCwPeNR5XQp3po+0lefS9yA@nongnu.org
X-Gm-Message-State: AOJu0YxIAUm+nOJlvgsq/iE7zEMMICxsOhEIfeEi7+/lVeq+4VdWWuJ+
 eZp7KLICWC0MlyJtvlMfe70RfeAaM12+NbvfYyLXkk2VYCN1wmae0Ati4e8qGoGndYK+RNiBLQ5
 K5JovhQYeWut3iRcC/4277v8bqFyBqbac7XTW0VnWA3IBPEXq2/MyNzS7
X-Gm-Gg: ATEYQzxwRyC3BwzwlaQ2hSFQexASDhkhwSKoQvGH00oZJrjcsbhf2vQsKcyqKj9gTNf
 38Ky2mtwe3qN3qk7d3Oe6gVS1me8X6GDcC+0TpQn7ynMx1+Qjhv2xRtwFY59VXUY7UsEHHTV6mZ
 Qd7x8OofBGc29Utg6uZx4C+81REuLgEkYs8MDJCdMqdej/jE/1bqE27dXz201x4TnrtyTcgtAaQ
 hshoLCvnNvtNiPdJzuYoobX4riXi0T6OD+o60ELuaF6aqzEnUtpnNNtht2jGVDhqO0JACQ366sf
 TbwuSQeFbmawwbHEABlDj1IeeH2jBX41b0rnlNtEr4hqPIuWqlpDh0hKSEiVffh0c5witC0THxJ
 eb7AdM8jNri7Umz5g8LZAYMBwbc5hSkO0aGwpIPLde5mmMs+SWCdYSZg9UG7SkD0QgV6kAyxaB4
 TYQAL2uEPj6ETYTxwxX7ZZLYuK5eiwXOKhWHLXCr72utVms5opFSA=
X-Received: by 2002:a05:600c:4514:b0:485:2f6a:6ed with SMTP id
 5b1f17b1804b1-4855670b701mr223333535e9.28.1773680345925; 
 Mon, 16 Mar 2026 09:59:05 -0700 (PDT)
X-Received: by 2002:a05:600c:4514:b0:485:2f6a:6ed with SMTP id
 5b1f17b1804b1-4855670b701mr223333135e9.28.1773680345537; 
 Mon, 16 Mar 2026 09:59:05 -0700 (PDT)
Received: from ?IPV6:2003:cf:d737:d02c:3210:ed4b:e671:ceb9?
 (p200300cfd737d02c3210ed4be671ceb9.dip0.t-ipconnect.de.
 [2003:cf:d737:d02c:3210:ed4b:e671:ceb9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856ea9c387sm5792585e9.8.2026.03.16.09.59.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 09:59:04 -0700 (PDT)
Message-ID: <a09d7754-78d9-4239-a3f1-749646a12180@redhat.com>
Date: Mon, 16 Mar 2026 17:59:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] block/mirror: fix assertion failure upon duplicate
 complete for job using 'replaces'
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, qemu-stable@nongnu.org
References: <20260311145717.668492-1-f.ebner@proxmox.com>
 <20260311145717.668492-2-f.ebner@proxmox.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20260311145717.668492-2-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 11.03.26 15:54, Fiona Ebner wrote:
> If s->replace_blocker was already set by an earlier invocation of
> mirror_complete(), then there will be an assertion failure when
> error_setg() is called for it a second time. The bdrv_op_block_all()
> and bdrv_ref() operations should only be done a single time too.
>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>   block/mirror.c | 28 +++++++++++++++-------------
>   1 file changed, 15 insertions(+), 13 deletions(-)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


