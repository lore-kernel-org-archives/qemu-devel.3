Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D1ACCCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 19:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9TjK-0005h1-Fv; Thu, 16 Oct 2025 15:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1v9TjI-0005gd-40
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 15:33:40 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1v9Tj8-0000z1-M7
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 15:33:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1760643195; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Y6Y/vVgYSydU1T4gCWR6mGWwbz1k/WERiGeKygL00Pfk7Viqfvz2pQiUTWQQZWXm+dINUUF9GoJUM+emM52AL2t/u/utqa3mswrBIxetxgBpVX2/4JzjPuPedHbBGqmkpaBe1BrfU1ov3IYL0BEBfh3GTu1wKbvTmbjRyeVtEFA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1760643195;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=yPHQeSD/zD4nHv/rzqixYrG72gB9TQHh756eXIZAmr0=; 
 b=S+xInIF3/qNkjS2KIhQVACRcC8+sFgG0/w22BwCWClXYo4Y9Pwyj2KvA1jC1P4XC/SERukJu2ww7V92AWXQYSPk3XVsVN1xGP/MCCw/8hpV083X5GM31f6vXa4DTCpvhusU8+1HqG/HFcIjPiErEoxbxfpttkQc9HAmKgS6qz6c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760643195; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=yPHQeSD/zD4nHv/rzqixYrG72gB9TQHh756eXIZAmr0=;
 b=dZE6B9w3fZE0+InW3zDgaSvFM5F/1HdOv4zfZVxk4EV1UqZM3dBy0R/zc5FpQS2e
 KQBTdBTKnzmoOvhMoZeEguDvC0W5A3GXsEzzQuI+nTWsvhuCuXRds+jJMfGs8+dcUjP
 dxFNPgeXGwa8hEf6N+VtcCdU+N4PEoyeK0Y++dd8=
Received: by mx.zohomail.com with SMTPS id 1760643192599174.48950353644352;
 Thu, 16 Oct 2025 12:33:12 -0700 (PDT)
Message-ID: <cc38a1ac-6f05-4c27-90a5-6ed71d9b566c@collabora.com>
Date: Thu, 16 Oct 2025 22:33:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Unify force quiescent state
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand
 <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20251016-force-v1-1-919a82112498@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20251016-force-v1-1-919a82112498@rsg.ci.i.u-tokyo.ac.jp>
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

On 10/16/25 09:34, Akihiko Odaki wrote:
> -        /* Wait for one thread to report a quiescent state and try again.
> +        /*
> +         * Sleep for a while and try again.
>           * Release rcu_registry_lock, so rcu_(un)register_thread() doesn't
>           * wait too much time.
>           *
> @@ -133,7 +150,20 @@ static void wait_for_readers(void)
>           * rcu_registry_lock is released.
>           */
>          qemu_mutex_unlock(&rcu_registry_lock);
> -        qemu_event_wait(&rcu_gp_event);
> +
> +        if (forced) {
> +            qemu_event_wait(&rcu_gp_event);
> +
> +            /*
> +             * We want to be notified of changes made to rcu_gp_ongoing
> +             * while we walk the list.
> +             */
> +            qemu_event_reset(&rcu_gp_event);
> +        } else {
> +            g_usleep(10000);
> +            sleeps++;

Thanks a lot for this RCU improvement. It indeed removes the hard stalls
with unmapping of virtio-gpu blobs.

Am I understanding correctly that potentially we will be hitting this
g_usleep(10000) and stall virtio-gpu for the first ~10ms? I.e. the
MemoryRegion patches from Alex [1] are still needed to avoid stalls
entirely.

[1]
https://lore.kernel.org/qemu-devel/20251014111234.3190346-6-alex.bennee@linaro.org/

-- 
Best regards,
Dmitry

