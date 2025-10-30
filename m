Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3134CCCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 11:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEQfS-0000o7-1r; Thu, 30 Oct 2025 07:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vEQfL-0000ne-4s
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 07:18:03 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vEQfF-0004UL-34
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 07:18:02 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1761823059; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=c8Ku8i94OUI7hoMXTB4RgPOUPRe/Y1lkpISdBRO2sMC8EcYG0CCY3LwI6knWnNB+j96VnY+/kb+qqCD0dGCRWz7Rv2Go4ffoBdKT1wpvg9DpaO6Rr/fxCxgyzfloDTR0KtkM7nJ6cKHt0sbev9PZmH2GNusM+qaT3CiigXt+Txg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1761823059;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=iQmhEDhASNV53AOGQ+WySP40vM1jazn7K182owX6Es4=; 
 b=MNWWKfza1KBO+YoTzI8PPd1B7QirjsGkwIoig0csq0i/RkZ1pDIO97S+ORrcd3s4InyJOQRCgUD+zErxIuEavvKWHbMwr4BFfy6GlcMSHRvOvHBiQOmKB6gUK8uslc9bILf5hw1ORqxQykgbLp87XrgMCqkihx1i9/E8w48Kx7I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761823059; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=iQmhEDhASNV53AOGQ+WySP40vM1jazn7K182owX6Es4=;
 b=WlZYsXQabXb3HDJbnGu4kKlmxT7C9GIUaN+QzmqNHfEFRgnbF5ZwTIdL3CAQA6Vr
 XdvMyFy/VtknxJRYg5DY767c64qh4kdb5vGtEF4G+JHuUwq49SS8+jP0KqOEufXG/GC
 +TwTqsjPeyTipdO7Mk1phgfygZyMFS+bYNhQgQi4=
Received: by mx.zohomail.com with SMTPS id 1761823057268556.5799245974283;
 Thu, 30 Oct 2025 04:17:37 -0700 (PDT)
Message-ID: <2f4bfdd5-3cf5-460b-95e2-7c373cff1ff5@collabora.com>
Date: Thu, 30 Oct 2025 14:17:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] virtio-gpu: Force RCU when unmapping blob
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20251029-force_rcu-v1-0-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20251029-force_rcu-v1-0-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hello Akihiko,

On 10/29/25 09:12, Akihiko Odaki wrote:
> Based-on: <20251016-force-v1-1-919a82112498@rsg.ci.i.u-tokyo.ac.jp>
> ("[PATCH] rcu: Unify force quiescent state")
> 
> Unmapping a blob changes the memory map, which is protected with RCU.
> RCU is designed to minimize the read-side overhead at the cost of
> reclamation delay. While this design usually makes sense, it is
> problematic when unmapping a blob because the operation blocks all
> virtio-gpu commands and causes perceivable disruption.
> 
> Minimize such the disruption with force_rcu(), which minimizes the
> reclamation delay at the cost of a read-side overhead.
> 
> Dmitry, can you see if this change makes difference?

Tested this series with venus and native contexts.

The improvement is very noticeable. There are almost no stalls with
venus and much less stalls with native context. The stall now takes
2-10ms at max in oppose to 50ms that was observed previously. No
stability issues spotted, everything works.

Thank you for working on this improvement.

-- 
Best regards,
Dmitry

