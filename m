Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC881E9E311
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 14:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqBAI-0004d8-Kr; Wed, 11 Feb 2026 09:26:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqBAH-0004cq-3n
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 09:26:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqBAE-0001bd-TW
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 09:26:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770819957;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ivKRfshYaGNArPaVvPxFLk0igg1j/lqR7lhmpY9gbQ=;
 b=RW20gzr+aH7+HQ2cTMMP03K5vOVlL9AvvTGrz9WnHgf6f8kDRjnn6hzDHPzIyJrdjp4lWf
 nlhga5ERwzcD442KCi49JKYZUOvXtanvv/+0OR4U7RzjxI9eN0RMFU7boDeD576bjFglyo
 FC0h6mXE566A5Cxf+U3L4JUjugwR/bk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-MmP7tbg3M9OykAUDNoLktQ-1; Wed, 11 Feb 2026 09:25:55 -0500
X-MC-Unique: MmP7tbg3M9OykAUDNoLktQ-1
X-Mimecast-MFC-AGG-ID: MmP7tbg3M9OykAUDNoLktQ_1770819955
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4363333c102so1346667f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 06:25:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770819954; x=1771424754;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ivKRfshYaGNArPaVvPxFLk0igg1j/lqR7lhmpY9gbQ=;
 b=ttZ729ZGmTqV0EGb9nkuPsyLuyNg2WNveq+2i3zSo7NhF5ffyYY5qYWmqw3DE316qv
 NJLsiAxX9/JLqJkb972hDaQnzfdE6vBvISxTx5qsFYEd+Qk7rzFsu7DVZ+VBQ2EBv31g
 G8mbfuDq1UfvjyRDb66wySC/Tt0s2WrLL5gsw+d/VcYVV/+HddNQ1l1+XJL3/9A3oQRI
 6qlmgOYIEZUPEGkLMrIKqzzN10BMeqEwj5KzGxkZUPXRDywCeB1P4+miuzocRgUVIDXR
 kchcigXxRusNOaqQop1vwl1bZ4PD7k3gKWDzZ9U9KLrnHzbe/a3GXf4vpsvp3j6oSFD4
 +X6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsShv3WoFN9vkS7fQCez2x77fXdu5HRA6Fm0S8GVHo65GR7wIzBp2WCI/JPQe2Pk+DpLd+WYr1fgns@nongnu.org
X-Gm-Message-State: AOJu0YyKqh2Lz+CxRP8dTvnp4R78sYZRBwpNMlDPBWMp5gwwsMLWJKmD
 K6t1oJK/JEd0q4+4bcvlrxyBMR5tMHWWtmKA3fSbOC7a/Po/dNipZKODNIhrlFjByO4SpB7gmqF
 TXRvfhbKY3tMnlLeBQ4Yg/JFX6yufUrKBcdxnoslD+DqPcamhPxzDVZVF
X-Gm-Gg: AZuq6aLJ9E9kYEwD7mrW8JLXMSris+P83DApY63twq4nszQIMU9iZBEWL26Z4uGSDDc
 Nw5UtMlPngpXEMU0hr/0vlbb5lixPPtzsbhmPdTTF9QCZ6jpEnwBVCh5SN7ikeQXwroYw2fk5ze
 I+0ZkCNzw1+tQ8mKgB0H7sc2GA8/F3uzzEGPBoqGzcbXryFoDATL8P9kGsUlPm0MJTJ2Cb27dyN
 ++Tex0SMMPI6LiEUJEAWNZpkv6pXCK2M+oEpuoDxd0EBLUWJgf2Z/LgXuDDYhDwryDTIwNYxclD
 e/RnGVx9PlgpIHnyl5SlxLs/uPHZacSDiyKGwSlB1HuXsBSQYVerndbONupTAbdUmNA5R7P2b3v
 MlJgFlE4AXp676poydu5tUUPYJ30P7eG8AgkghyKMydcqSDagb/cz1ywl0mz0YTVE6mrLKg==
X-Received: by 2002:a05:6000:2c02:b0:436:14d2:5414 with SMTP id
 ffacd0b85a97d-43629385637mr26431047f8f.55.1770819954445; 
 Wed, 11 Feb 2026 06:25:54 -0800 (PST)
X-Received: by 2002:a05:6000:2c02:b0:436:14d2:5414 with SMTP id
 ffacd0b85a97d-43629385637mr26430981f8f.55.1770819953945; 
 Wed, 11 Feb 2026 06:25:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783e38e26sm4930169f8f.26.2026.02.11.06.25.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Feb 2026 06:25:53 -0800 (PST)
Message-ID: <275ab451-4c37-4a78-bf5b-a76329bbf873@redhat.com>
Date: Wed, 11 Feb 2026 15:25:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] hw/arm/smmuv3-accel: Read and propagate host
 vIOMMU events
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nicolinc@nvidia.com, nathanc@nvidia.com,
 mochs@nvidia.com, jan@nvidia.com, jgg@nvidia.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, kjaju@nvidia.com
References: <20260211083415.133534-1-skolothumtho@nvidia.com>
 <20260211083415.133534-6-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260211083415.133534-6-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shameer,

On 2/11/26 9:34 AM, Shameer Kolothum wrote:
> Install an event handler on the vEVENTQ fd to read and propagate host
> generated vIOMMU events to the guest.
>
> The handler runs in QEMU's main loop, using a non-blocking fd registered
> via qemu_set_fd_handler().
>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c | 62 +++++++++++++++++++++++++++++++++++++++++++
>  hw/arm/smmuv3-accel.h |  2 ++
>  2 files changed, 64 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index d92fcb1a89..0d5dcef941 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -390,6 +390,48 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
>                     sizeof(Cmd), &entry_num, cmd, errp);
>  }
>  
> +static void smmuv3_accel_event_read(void *opaque)
> +{
> +    SMMUv3State *s = opaque;
> +    SMMUv3AccelState *accel = s->s_accel;
> +    struct {
> +        struct iommufd_vevent_header hdr;
> +        struct iommu_vevent_arm_smmuv3 vevent;
> +    } buf;
> +    uint32_t last_seq = accel->last_event_seq;
> +    ssize_t bytes;
> +
> +    bytes = read(accel->veventq->veventq_fd, &buf, sizeof(buf));
> +    if (bytes <= 0) {
> +        if (errno == EAGAIN || errno == EINTR) {
> +            return;
> +        }
> +        error_report_once("vEVENTQ: read failed (%m)");
> +        return;
> +    }
> +
> +    if (bytes == sizeof(buf.hdr) &&
> +        (buf.hdr.flags & IOMMU_VEVENTQ_FLAG_LOST_EVENTS)) {
> +        error_report_once("vEVENTQ has lost events");
in case in the future we end up with several vEVENTQs, it may be
relevant to log the queue id/type

After reading the linux uapi again, this seems to record a queue
overflow. I would replace the 

"vEVENTQ has lost events" trace by "queue <type> <id> has overflowed". This would allow differentiation with the case below.

> +        accel->event_start = false;
> +        return;
> +    }
> +    if (bytes < sizeof(buf)) {
> +        error_report_once("vEVENTQ: incomplete read (%zd/%zd bytes)",
> +                          bytes, sizeof(buf));
> +        return;
> +    }
> +
> +    /* Check sequence in hdr for lost events if any */
> +    if (accel->event_start && (buf.hdr.sequence - last_seq != 1)) {
wonder if we need to handle any hypothetical wrap-up situation?
> +        error_report_once("vEVENTQ: detected lost %u event(s)",
> +                          buf.hdr.sequence - last_seq - 1);
> +    }
> +    accel->last_event_seq = buf.hdr.sequence;
> +    accel->event_start = true;
> +    smmuv3_propagate_event(s, (Evt *)&buf.vevent);
> +}
> +
>  static void smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
>  {
>      IOMMUFDVeventq *veventq = accel->veventq;
> @@ -397,6 +439,7 @@ static void smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
>      if (!veventq) {
>          return;
>      }
> +    qemu_set_fd_handler(veventq->veventq_fd, NULL, NULL, NULL);
>      close(veventq->veventq_fd);
>      iommufd_backend_free_id(accel->viommu->iommufd, veventq->veventq_id);
>      g_free(veventq);
> @@ -424,6 +467,7 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
>      IOMMUFDVeventq *veventq;
>      uint32_t veventq_id;
>      uint32_t veventq_fd;
> +    int flags;
>  
>      if (!accel || !accel->viommu) {
>          return true;
> @@ -445,12 +489,30 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
>          return false;
>      }
>  
> +    flags = fcntl(veventq_fd, F_GETFL);
> +    if (flags < 0) {
> +        error_setg_errno(errp, errno, "Failed to get flags for vEVENTQ fd");
> +        goto free_veventq;
> +    }
> +    if (fcntl(veventq_fd, F_SETFL, flags | O_NONBLOCK) < 0) {
> +        error_setg_errno(errp, errno, "Failed to set O_NONBLOCK on vEVENTQ fd");
> +        goto free_veventq;
> +    }
> +
>      veventq = g_new(IOMMUFDVeventq, 1);
>      veventq->veventq_id = veventq_id;
>      veventq->veventq_fd = veventq_fd;
>      veventq->viommu = accel->viommu;
>      accel->veventq = veventq;
> +
> +    /* Set up event handler for veventq fd */
> +    qemu_set_fd_handler(veventq_fd, smmuv3_accel_event_read, NULL, s);
>      return true;
> +
> +free_veventq:
> +    close(veventq_fd);
> +    iommufd_backend_free_id(accel->viommu->iommufd, veventq_id);
> +    return false;
>  }
>  
>  static bool
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index dba6c71de5..c9c10e55c3 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -23,6 +23,8 @@
>  typedef struct SMMUv3AccelState {
>      IOMMUFDViommu *viommu;
>      IOMMUFDVeventq *veventq;
> +    uint32_t last_event_seq;
> +    bool event_start;
>      uint32_t bypass_hwpt_id;
>      uint32_t abort_hwpt_id;
>      QLIST_HEAD(, SMMUv3AccelDevice) device_list;
Thanks

Eric


