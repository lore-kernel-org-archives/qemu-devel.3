Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78953CFD35A
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 21:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNe9h-0003jN-5G; Mon, 24 Nov 2025 16:31:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vNe9f-0003hQ-ON
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 16:31:27 -0500
Received: from sender3-pp-f112.zoho.com ([136.143.184.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vNe9d-0002e3-B2
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 16:31:26 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1764019872; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=c+zO4KklX2doG8hrm23qYa8jQTaJbrDPe4ScW+o3A/jd0I1rl57+iOIAjqG3eYVjrpTRa6hB/srdwjYSqt5taT0kF1dsn2KkJCyddPOEQj3E22U4urdKutzoK9NcoV0CMgPw+3YgNXgOjlpvxmxmnTfe6TJvfafeQ00Tyrwny/k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1764019872;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=DN7Pl5BbWJwEU6j5r8/UL7sdbAI+i04cAS5Hl6v0fXg=; 
 b=DkfRuh8E6IXp8ruj1QyHd0O85BUhMqWEq0fmjb7PYavvI3Gwjvjn342uBw7GYOgN7w3CvRIHqnuMzPsVgHN9NNNMte1/AeuJsK+3H1ijRKA4u0H2jX2/4WKtuAYpeJXezAFGi6mKPDsGE0Se83uuoiLo79hF8Pyq/I5lS2ZYeuY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764019872; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=DN7Pl5BbWJwEU6j5r8/UL7sdbAI+i04cAS5Hl6v0fXg=;
 b=iPj/cKzAn/Pl3wpsB83LhKNt0YD+8cwEpr54T4JVKgPuZaAJ0LMzish+RQQZVEgC
 xGqOp275xy/4jD7vm47i7hWzsTg0z6uggORbN6tcQE5Zdmi49cahlQl1VWVdJFs/Ocy
 aJntGO1CZxdqdnMiRaJ+TNcTxAKYZBydhUezxjq0=
Received: by mx.zohomail.com with SMTPS id 1764019871598265.5022961480196;
 Mon, 24 Nov 2025 13:31:11 -0800 (PST)
Message-ID: <5d48ae13-eb21-440a-a604-9f90a8e9c11f@collabora.com>
Date: Tue, 25 Nov 2025 00:31:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 2/2] virtio-gpu: use consistent error checking for
 virtio_gpu_create_mapping_iov
To: Honglei Huang <honghuan@amd.com>, alex.bennee@linaro.org,
 odaki@rsg.ci.i.u-tokyo.ac.jp, armbru@redhat.com
Cc: mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, Ray.Huang@amd.com
References: <20251124032423.227712-1-honghuan@amd.com>
 <20251124032423.227712-3-honghuan@amd.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20251124032423.227712-3-honghuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.184.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender3-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 11/24/25 06:24, Honglei Huang wrote:
> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
> index ed5ae52acb..ea2928b706 100644
> --- a/hw/display/virtio-gpu-rutabaga.c
> +++ b/hw/display/virtio-gpu-rutabaga.c
> @@ -466,7 +466,7 @@ rutabaga_cmd_attach_backing(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
>  
>      ret = virtio_gpu_create_mapping_iov(g, att_rb.nr_entries, sizeof(att_rb),
>                                          cmd, NULL, &res->iov, &res->iov_cnt);
> -    CHECK(!ret, cmd);
> +    CHECK(ret >= 0, cmd);
>  
>      vecs.iovecs = res->iov;
>      vecs.num_iovecs = res->iov_cnt;
> @@ -616,7 +616,7 @@ rutabaga_cmd_resource_create_blob(VirtIOGPU *g,
>          result = virtio_gpu_create_mapping_iov(g, cblob.nr_entries,
>                                                 sizeof(cblob), cmd, &res->addrs,
>                                                 &res->iov, &res->iov_cnt);
> -        CHECK(!result, cmd);
> +        CHECK(result >= 0, cmd);
>      }

The ret < 0 part looks okay, but ret >= 0 feels dubious to me given that
this func doesn't return positive values.

-- 
Best regards,
Dmitry

