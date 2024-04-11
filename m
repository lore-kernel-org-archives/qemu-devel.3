Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48963CD128A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 12:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rutuu-0007mz-4c; Thu, 11 Apr 2024 08:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1rutuq-0007mf-TC
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 08:52:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1rutuo-0006dh-NX
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 08:52:32 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43BBG32x016643; Thu, 11 Apr 2024 12:52:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 qcppdkim1; bh=1757u5SJJzls5fJdmO2OFJDZvjalxFgfmpHD2zOC+pA=; b=aq
 w6MqyVTWf5P23xYVENXTJmPjpKjzsLG8miypqOwEhysz+/dPAd9Lb2xhg+W07Yc4
 UE3PHYGeYtUHzxKsOl+B6EYfq9+ceQWin7K4e2Yokeb6A8d303nSQoxip4VtePEj
 CJYdBPNe2jLhO5ieNaUKE5j6K43zIDMglBiVfqccRILUezJ6nQDg6ne+EGeGG2rD
 6Y5ljPdNTqajrCDrY+k/FJ5hGGDG8MfqJlTnY6oupAofrxe8I1PuA9CMmLFRwUde
 7XNyc8hsSSb9yQi3KchCxULiQ9J3XnGacS3OlHel2iwbazTaiV3v3zrySeO0CJrW
 UMaj6HNvpgwuJSO9y0kQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xeb2rhdrq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Apr 2024 12:52:14 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43BCqDkX017445
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Apr 2024 12:52:13 GMT
Received: from [10.111.132.126] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 11 Apr
 2024 05:52:07 -0700
Message-ID: <573ac65a-8047-4d33-9995-36ca15b97a15@quicinc.com>
Date: Thu, 11 Apr 2024 14:52:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/10] virtio-gpu: Support Venus capset
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, Akihiko Odaki
 <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Gerd Hoffmann
 <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Stefano
 Stabellini <sstabellini@kernel.org>, Anthony PERARD
 <anthony.perard@citrix.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>, Gert Wollny
 <gert.wollny@collabora.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
CC: <qemu-devel@nongnu.org>, Gurchetan Singh <gurchetansingh@chromium.org>,
 <ernunes@redhat.com>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, Alex Deucher
 <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>, Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>,
 Julia Zhang <julia.zhang@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>
References: <20240411102002.240536-1-dmitry.osipenko@collabora.com>
 <20240411102002.240536-10-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Antonio Caggiano <quic_acaggian@quicinc.com>
In-Reply-To: <20240411102002.240536-10-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: ow1gWPmO7xYbbj4CErLyi9X8LWxUOYxf
X-Proofpoint-GUID: ow1gWPmO7xYbbj4CErLyi9X8LWxUOYxf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_06,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 phishscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404110093
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_acaggian@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi Dmitry,

I have a new version of this patch which you might want to include in 
this series.
Please, you can find it below.

I hope it would also solve the issue raised by Pierre-Eric in v6.

Cheers,
Antonio

---
virtio-gpu: Support Venus capset

While querying the number of capsets, map each index to the relative
capset ID, then reuse this mapping when querying for the capset info.
This is a flexible approach which allows to add support for new capsets
in the future more easily.

Then add support for the Venus capset, which enables Vulkan support through
the Venus Vulkan driver for virtio-gpu.

Signed-off-by: Antonio Caggiano <quic_acaggian@quicinc.com>
---
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 9f34d0e661..0e9e4ebcbb 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -371,17 +371,13 @@ static void virgl_cmd_get_capset_info(VirtIOGPU *g,
  {
      struct virtio_gpu_get_capset_info info;
      struct virtio_gpu_resp_capset_info resp;
+    VirtIOGPUGL* gl = VIRTIO_GPU_GL(g);

      VIRTIO_GPU_FILL_CMD(info);

      memset(&resp, 0, sizeof(resp));
-    if (info.capset_index == 0) {
-        resp.capset_id = VIRTIO_GPU_CAPSET_VIRGL;
-        virgl_renderer_get_cap_set(resp.capset_id,
-                                   &resp.capset_max_version,
-                                   &resp.capset_max_size);
-    } else if (info.capset_index == 1) {
-        resp.capset_id = VIRTIO_GPU_CAPSET_VIRGL2;
+    if (info.capset_index < VIRTIO_GPU_MAX_CAPSETS) {
+        resp.capset_id = gl->capset_ids[info.capset_index];
          virgl_renderer_get_cap_set(resp.capset_id,
                                     &resp.capset_max_version,
                                     &resp.capset_max_size);
@@ -658,10 +654,28 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)

  int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g)
  {
-    uint32_t capset2_max_ver, capset2_max_size;
+    uint32_t capset_max_ver, capset_max_size;
+    uint32_t capset_count = 0;
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
+
+    gl->capset_ids[capset_count] = VIRTIO_GPU_CAPSET_VIRGL;
+    capset_count++;
+
      virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VIRGL2,
-                              &capset2_max_ver,
-                              &capset2_max_size);
+                              &capset_max_ver,
+                              &capset_max_size);
+    if (capset_max_ver) {
+        gl->capset_ids[capset_count] = VIRTIO_GPU_CAPSET_VIRGL2;
+        capset_count++;
+    }
+
+    virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VENUS,
+                              &capset_max_ver,
+                              &capset_max_size);
+    if (capset_max_size) {
+        gl->capset_ids[capset_count] = VIRTIO_GPU_CAPSET_VENUS;
+        capset_count++;
+    }

-    return capset2_max_ver ? 2 : 1;
+    return capset_count;
  }
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index ed44cdad6b..c0e7cae42e 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -225,11 +225,15 @@ struct VirtIOGPUClass {
                               Error **errp);
  };

+#define VIRTIO_GPU_MAX_CAPSETS 8
+
  struct VirtIOGPUGL {
      struct VirtIOGPU parent_obj;

      bool renderer_inited;
      bool renderer_reset;
+
+    int capset_ids[VIRTIO_GPU_MAX_CAPSETS];
  };

  struct VhostUserGPU {


On 11/04/2024 12:20, Dmitry Osipenko wrote:
> From: Antonio Caggiano <antonio.caggiano@collabora.com>
> 
> Add support for the Venus capset, which enables Vulkan support through
> the Venus Vulkan driver for virtio-gpu.
> 
> Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   hw/display/virtio-gpu-virgl.c | 21 +++++++++++++++++----
>   1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index e01ab8295d4d..0d8f00c7939a 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -517,6 +517,11 @@ static void virgl_cmd_get_capset_info(VirtIOGPU *g,
>           virgl_renderer_get_cap_set(resp.capset_id,
>                                      &resp.capset_max_version,
>                                      &resp.capset_max_size);
> +    } else if (info.capset_index == 2) {
> +        resp.capset_id = VIRTIO_GPU_CAPSET_VENUS;
> +        virgl_renderer_get_cap_set(resp.capset_id,
> +                                   &resp.capset_max_version,
> +                                   &resp.capset_max_size);
>       } else {
>           resp.capset_max_version = 0;
>           resp.capset_max_size = 0;
> @@ -1067,10 +1072,18 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>   
>   int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g)
>   {
> -    uint32_t capset2_max_ver, capset2_max_size;
> +    uint32_t capset2_max_ver, capset2_max_size, num_capsets;
> +    num_capsets = 1;
> +
>       virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VIRGL2,
> -                              &capset2_max_ver,
> -                              &capset2_max_size);
> +                               &capset2_max_ver,
> +                               &capset2_max_size);
> +    num_capsets += capset2_max_ver ? 1 : 0;
> +
> +    virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VENUS,
> +                               &capset2_max_ver,
> +                               &capset2_max_size);
> +    num_capsets += capset2_max_size ? 1 : 0;
>   
> -    return capset2_max_ver ? 2 : 1;
> +    return num_capsets;
>   }

