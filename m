Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0C0C5B559
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 11:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN8mI-0003Yu-HP; Thu, 05 Jun 2025 07:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uN8mG-0003YS-Ds
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 07:28:56 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uN8mD-0005w9-Mj
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 07:28:55 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a5096158dcso717650f8f.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 04:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749122931; x=1749727731; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M0R5R1DwIfAtfAuGtMpSyTydgmnF5F34oJMgISH+I34=;
 b=GV3xHsmVuLJ1MxILauqdQ1QJlGJqFpodOnAKyF9S6dFAnFuGHdAoA26jPp4hDrRk05
 HYAKC0e8tm6SO78cYzL6iwVDzmslfXYuxRAfWzmNxoc/dEDAPnirvDPnMslhe5tZYO/t
 vM+t0s3DhWjQgSG0XFDAOnQq7qqHml1OKg1+cNUnPNoRsJvNdBUcNRjSGSWr5uYn7JXc
 9A9YJSaHM4MtFW6dVxg53jfvJ7xNkO5eJAsLt7na5x6fyv9LCCdHgPbRkmQnum+WWaPn
 NJm0A5ySbGmFhbgNJPtb49ZRS/oPiJwpVGV5xoK6XiJa28codfsxfGKl/kr3bAmv5+N0
 QQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749122931; x=1749727731;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M0R5R1DwIfAtfAuGtMpSyTydgmnF5F34oJMgISH+I34=;
 b=EFPeOLCwzENSqtKqf+dbwIKMEqhoHuUV8Yji1nhRUMIIzGfpI+AX7ETNot04JV2apK
 RDvZ+BMfWXIbv76u6+5HxOaKELRTmNGTIISqbQsVWuruA/dWP10zS+ViYgylYXhWhPPy
 dOzPoVGZRbBFVllT5rqqLnbhxqv/wioTIHfpPBUBhn4PubTGBI2bWlI5gap3wKHEYDHt
 Lh3wECu/wpWCSieI29q6rymm3KYDZ/nF4NFrWo/omAQn1bC+wH9wfMk/9Mlp5o5I1YW0
 Otodw9qay9WgtqVVdk1WzC33BJVOSF/pzzcSXlsVsdc3/KleCcnL/LZjrRn0P+kERwHn
 dhQQ==
X-Gm-Message-State: AOJu0Ywq6jyZNRclaLmC/7tLYl6uHbZDFyb3/BEeNIqiyLNyWv+J0RzG
 coWPn56NLjoqdbxWphn1pIeD1KnFb5IsE11s/VSmf/+g1vG004WoLVIkbQZfEXRsKhQ=
X-Gm-Gg: ASbGncuQn4O5T3YEPWKOaYRMuB7hfqJ4mF6zUMrbcRJxld+WVJqQttO+bX1EaIIKFoB
 9HFvIBxWDycGvYJHcRpafOGP6ZwHakkfiDN9/FtedkkNWzB77KxrV+YNe/H5I/8LkWVNMmKZ1MN
 8SpgGdW/h8FLm1RqRHfmZ0Zz9OsZ+E13JhfWcPdhyYZgFH/YT0kkgQ8Bo2AdyOHaXrBbm1Gr/xp
 9HlcGD9wVIdXJVIXBBdzJgOaQ5KFfFMQQkVVxBaWd5da9QRqTNI0Czb73UAue1tXPlZSLIHh2gi
 GJA6bF488xZMLi2j/qXl5Nnz0+5BbrsbZl8HTYChFtFq8P3bQMwxKMHT2cAIAcTdXyS0zvI/9SM
 W836cwWBFLYkFqfvDzQo3lQf2Q0lJHw==
X-Google-Smtp-Source: AGHT+IHayXh0cy8+RchkxrSG31IsObzAsSRlD5Kx4T66n5fi5PqL8wXaGNpb2srUYFxsB3XDt6yKDw==
X-Received: by 2002:a05:6000:26d3:b0:3a4:f6fe:5244 with SMTP id
 ffacd0b85a97d-3a51d9241e9mr5216692f8f.12.1749122930731; 
 Thu, 05 Jun 2025 04:28:50 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a524ff8972sm2869846f8f.25.2025.06.05.04.28.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 04:28:50 -0700 (PDT)
Message-ID: <42276df1-4267-4038-8685-c7a193259e67@linaro.org>
Date: Thu, 5 Jun 2025 13:28:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio: avoid cost of -ftrivial-auto-var-init in hot path
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250604191843.399309-1-stefanha@redhat.com>
 <aEFWeZUlqqRvHsJT@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aEFWeZUlqqRvHsJT@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 5/6/25 10:34, Daniel P. Berrangé wrote:
> On Wed, Jun 04, 2025 at 03:18:43PM -0400, Stefan Hajnoczi wrote:
>> Since commit 7ff9ff039380 ("meson: mitigate against use of uninitialize
>> stack for exploits") the -ftrivial-auto-var-init=zero compiler option is
>> used to zero local variables. While this reduces security risks
>> associated with uninitialized stack data, it introduced a measurable
>> bottleneck in the virtqueue_split_pop() and virtqueue_packed_pop()
>> functions.
>>
>> These virtqueue functions are in the hot path. They are called for each
>> element (request) that is popped from a VIRTIO device's virtqueue. Using
>> __attribute__((uninitialized)) on large stack variables in these
>> functions improves fio randread bs=4k iodepth=64 performance from 304k
>> to 332k IOPS (+9%).
> 
> IIUC, the 'hwaddr addr' variable is 8k in size, and the 'struct iovec iov'
> array is 16k in size, so we have 24k on the stack that we're clearing and
> then later writing the real value. Makes sense that this would have a
> perf impact in a hotpath.
> 
>> This issue was found using perf-top(1). virtqueue_split_pop() was one of
>> the top CPU consumers and the "annotate" feature showed that the memory
>> zeroing instructions at the beginning of the functions were hot.
> 
> When you say you found it with 'perf-top' was that just discovered by
> accident, or was this usage of perf-top in response to users reporting
> a performance degradation vs earlier QEMU ?

Would it make sense to move these to VirtQueue (since the structure
definition is local anyway)?

-- >8 --
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 85110bce374..b96c6ec603c 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -153,6 +153,12 @@ struct VirtQueue
      EventNotifier host_notifier;
      bool host_notifier_enabled;
      QLIST_ENTRY(VirtQueue) node;
+
+    /* Only used by virtqueue_pop() */
+    struct {
+        hwaddr addr[VIRTQUEUE_MAX_SIZE];
+        struct iovec iov[VIRTQUEUE_MAX_SIZE];
+    } pop;
  };

  const char *virtio_device_names[] = {
@@ -1680,8 +1686,8 @@ static void *virtqueue_split_pop(VirtQueue *vq, 
size_t sz)
      VirtIODevice *vdev = vq->vdev;
      VirtQueueElement *elem = NULL;
      unsigned out_num, in_num, elem_entries;
-    hwaddr addr[VIRTQUEUE_MAX_SIZE];
-    struct iovec iov[VIRTQUEUE_MAX_SIZE];
+    hwaddr *addr = vq->pop.addr;
+    struct iovec *iov = vq->pop.iov;
      VRingDesc desc;
      int rc;

@@ -1826,8 +1832,8 @@ static void *virtqueue_packed_pop(VirtQueue *vq, 
size_t sz)
      VirtIODevice *vdev = vq->vdev;
      VirtQueueElement *elem = NULL;
      unsigned out_num, in_num, elem_entries;
-    hwaddr addr[VIRTQUEUE_MAX_SIZE];
-    struct iovec iov[VIRTQUEUE_MAX_SIZE];
+    hwaddr *addr = vq->pop.addr;
+    struct iovec *iov = vq->pop.iov;
      VRingPackedDesc desc;
      uint16_t id;
      int rc;
---

> 
>>
>> Fixes: 7ff9ff039380 ("meson: mitigate against use of uninitialize stack for exploits")
>> Cc: Daniel P. Berrangé <berrange@redhat.com>
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> ---
>>   include/qemu/compiler.h | 12 ++++++++++++
>>   hw/virtio/virtio.c      |  8 ++++----
>>   2 files changed, 16 insertions(+), 4 deletions(-)


