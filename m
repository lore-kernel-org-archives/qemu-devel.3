Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C58C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 14:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1P8i-0002gx-R1; Tue, 01 Sep 2026 10:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1x1P8g-0002ZT-L6
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 10:07:02 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1x1P8e-0005wA-8V
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 10:07:02 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6a5dce0aacdso11005a12.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 07:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788271619; x=1788876419; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6LV6C2dtoeXhJiWp0oQUTOR9Lqklz5jm+Z+x0pAP5RQ=;
 b=XSBBown/GeykSHXqnKgsOIfdpCbpPHf/HvOuD+16uThlC3glLpBEFt4NWselzFxTop
 Vzy0WYMv1xBsd4aLtn5sNS0/4l3OHxIHwMIqRTTHFBC0+Diy94F50HdU8SXl8kh/Jc+f
 QY/xIMACdgsYA3TdJT/I2f4sRVmwLF89qbJrfONU2EWqdhUQXJNDReByyeUX2elTgn1N
 vEa55swHvuRQtTQ4lc/TAKt4YQBC6+Qz6C7ZOv9Dh96OA5UhSVkPUU6SFRAjWzmAniUC
 AUlvg4GIT/n8AlVWTJ6bzvyXHm0R9uwsP04wA1nucHsBtZBJMM6vuPl0+VFlZKxd2Imj
 2lXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788271619; x=1788876419;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6LV6C2dtoeXhJiWp0oQUTOR9Lqklz5jm+Z+x0pAP5RQ=;
 b=QUD0G112er7Mut+bv6CG6FIMe3Rc3MvT7J+ABilh1JikCEQec1xpxgyfG98FexlnjB
 6DOND8pFKBMUEPf+lC1o1c3z6ubzw9RvjMeR3aJqZ1mBtXKxV9xL+DidQ7YwtwMMej23
 q+TdjT9dWJFzLYJrdzCFClQG6n8JByZJwwcDSooKuHtuUFhbNryTC6rXBFV/ZaHrsgT0
 G9FxbBHwdwWqd2GUlTFYBVw66CrRGA6pIVR0z+EJDK+y1JOO7vBXA/IFqT8vyx9XN6o2
 RElg/pPQyRNctIifaWLTFgRiqYtG6SGTfid0wDB/JUZqToq4f7y+e/crKD7hiZSAXAlL
 YqzA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzCJmy9SRrUx8VsdAWJwZEFy7Ph3SFIDMS1+0CxfNEo80/LYAKpGMMFErRggXBc5vH+BNmdcFpZQC+L@nongnu.org
X-Gm-Message-State: AFuF++lkH6xHpuc8rDll3qEmAE53Ff6tuaXd5EAJMfXNeGCwRQ8fKAZr
 f1Bkep33hzqKCIvjmkV9RYRD4Zs4tAHXLYXAvHju/Ok+V31GskJAcRF1fLR1E0XyHw==
X-Gm-Gg: AYBFou2P0wA5nAADrgA3lhodvC1hSeUCmuXG7RhzPLdzGmER7Z5JonYi4gVIRQmbPKY
 R/E3Xo/H59fiMofyWe7c401Q2/LxpbONK3IplFRY9MyHYhqkejfcZKjc3JoEvJhDhkeksQXU5WG
 AiBqHOFHB5Yy8WSyfDQgHfcQiPfFiaVD0LbfU4LgAPu1CiAzWZa5qpj9feytxWGcfK6H+T/Cgev
 kDJ7+//OzeH8jTCrMUC+xFT+BVAPUR5O4uxspEe1SUv6XV+nMynzVq+dRBMgPaaUbDeFGEhUEku
 LKCzeLWXZuzeOFywBVNVLzbzMqSTTHhg+m7pAv64HSdpDZnbvBo57JRkqnPjDHqJt3a3SvFkF2Q
 7y8FxavMgGHyiWcwEs2FKOBEVzHK6XNGR3JbkhIoLDKVJMdAViriu7BOMTMefbbK/VMX8hTwaiH
 +7dNpAT5MgRa6tbsNk553vBamtoCqJim2UIEBD2xpATp2KYi8+pGSLGNj3nHdM0wmYh4vmq26es
 IAytNbhgWRG4B19k0x+6PtnCfxYKg==
X-Received: by 2002:a05:6402:50f:b0:6a6:6ded:b4b6 with SMTP id
 4fb4d7f45d1cf-6a66dedb61cmr35205a12.13.1788271617944; 
 Tue, 01 Sep 2026 07:06:57 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com.
 [35.189.192.250]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a66ccb753bsm916641a12.4.2026.09.01.07.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 07:06:56 -0700 (PDT)
Date: Tue, 1 Sep 2026 14:06:52 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
Subject: Re: [RFC v5 08/28] hw/arm/smmu-common: Key configuration cache on
 SMMUDevice and SEC_SID
Message-ID: <apbb_HerT4qLaeTR@google.com>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162446.2806393-3-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813162446.2806393-3-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=smostafa@google.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Fri, Aug 14, 2026 at 12:24:44AM +0800, Tao Tang wrote:
> Adapt the configuration cache to distinguish entries decoded through
> different SEC_SID-selected programming interfaces by introducing a
> composite SMMUConfigKey. The key combines SMMUDevice with SEC_SID,
> preventing Secure and Non-secure configuration entries from aliasing in
> the cache and leaving the key extensible for a future Realm SEC_SID
> namespace.
> 
> The cache lookup, insertion, and invalidation mechanisms are updated to
> use this new keying infrastructure.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> Link: https://lore.kernel.org/qemu-devel/a9a840a6-c65f-4352-9a49-ddd1b5483f43@redhat.com/
> ---
>  hw/arm/smmu-common.c         | 45 ++++++++++++++++++++++++++++++++++--
>  hw/arm/smmuv3.c              | 12 ++++++----
>  include/hw/arm/smmu-common.h |  7 ++++++
>  3 files changed, 57 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 89e1e2826d4..63c36329a98 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -30,6 +30,26 @@
>  #include "hw/arm/smmu-common.h"
>  #include "smmu-internal.h"
>  
> +/* Configuration Cache Management */
> +static guint smmu_config_key_hash(gconstpointer key)
> +{
> +    const SMMUConfigKey *k = key;
> +    return g_direct_hash(k->sdev) ^ (guint)k->sec_sid;
> +}
> +
> +static gboolean smmu_config_key_equal(gconstpointer a, gconstpointer b)
> +{
> +    const SMMUConfigKey *ka = a;
> +    const SMMUConfigKey *kb = b;
> +    return ka->sdev == kb->sdev && ka->sec_sid == kb->sec_sid;
> +}
> +
> +SMMUConfigKey smmu_get_config_key(SMMUDevice *sdev, SMMUSecSID sec_sid)
> +{
> +    SMMUConfigKey key = {.sdev = sdev, .sec_sid = sec_sid};
> +    return key;
> +}
> +
>  ARMSecuritySpace smmu_get_security_space(SMMUSecSID sec_sid)
>  {
>      switch (sec_sid) {
> @@ -265,7 +285,8 @@ static gboolean smmu_hash_remove_by_vmid_ipa(gpointer key, gpointer value,
>  static gboolean
>  smmu_hash_remove_by_sid_range(gpointer key, gpointer value, gpointer user_data)
>  {
> -    SMMUDevice *sdev = (SMMUDevice *)key;
> +    SMMUConfigKey *config_key = (SMMUConfigKey *)key;
> +    SMMUDevice *sdev = config_key->sdev;
>      uint32_t sid = smmu_get_sid(sdev);
>      SMMUSIDRange *sid_range = (SMMUSIDRange *)user_data;
>  
> @@ -283,6 +304,24 @@ void smmu_configs_inv_sid_range(SMMUState *s, SMMUSIDRange sid_range)
>                                  &sid_range);
>  }
>  
> +static gboolean smmu_hash_remove_by_sdev(gpointer key, gpointer value,
> +                                         gpointer user_data)
> +{
> +    SMMUConfigKey *config_key = (SMMUConfigKey *)key;
> +    SMMUDevice *target = (SMMUDevice *)user_data;
> +
> +    if (config_key->sdev != target) {
> +        return false;
> +    }
> +    trace_smmu_config_cache_inv(smmu_get_sid(target));
> +    return true;
> +}
> +
> +void smmu_configs_inv_sdev(SMMUState *s, SMMUDevice *sdev)
> +{
> +    g_hash_table_foreach_remove(s->configs, smmu_hash_remove_by_sdev, sdev);
> +}
> +
>  void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
>                           uint8_t tg, uint64_t num_pages, uint8_t ttl)
>  {
> @@ -979,7 +1018,9 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
>          error_propagate(errp, local_err);
>          return;
>      }
> -    s->configs = g_hash_table_new_full(NULL, NULL, NULL, g_free);
> +    s->configs = g_hash_table_new_full(smmu_config_key_hash,
> +                                       smmu_config_key_equal,
> +                                       g_free, g_free);
>      s->iotlb = g_hash_table_new_full(smmu_iotlb_key_hash, smmu_iotlb_key_equal,
>                                       g_free, g_free);
>      s->smmu_pcibus_by_busptr = g_hash_table_new(NULL, NULL);
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 3ff2f498a3b..a01175cc672 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -952,7 +952,7 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
>   *
>   * The configuration cache contains data resulting from both STE and CD
>   * decoding under the form of an SMMUTransCfg struct. The hash table is indexed
> - * by the SMMUDevice handle.
> + * by a composite key of the SMMUDevice and the sec_sid.
>   */
>  static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event,
>                                         SMMUSecSID sec_sid)
> @@ -960,8 +960,9 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event,
>      SMMUv3State *s = sdev->smmu;
>      SMMUState *bc = &s->smmu_state;
>      SMMUTransCfg *cfg;
> +    SMMUConfigKey lookup_key = smmu_get_config_key(sdev, sec_sid);
>  
> -    cfg = g_hash_table_lookup(bc->configs, sdev);
> +    cfg = g_hash_table_lookup(bc->configs, &lookup_key);
>      if (cfg) {
>          sdev->cfg_cache_hits++;
>          trace_smmuv3_config_cache_hit(smmu_get_sid(sdev),
> @@ -977,7 +978,9 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event,
>          cfg = g_new0(SMMUTransCfg, 1);
>  
>          if (!smmuv3_decode_config(&sdev->iommu, cfg, event, sec_sid)) {
> -            g_hash_table_insert(bc->configs, sdev, cfg);
> +            SMMUConfigKey *persistent_key = g_new(SMMUConfigKey, 1);
> +            *persistent_key = lookup_key;
> +            g_hash_table_insert(bc->configs, persistent_key, cfg);
>          } else {
>              g_free(cfg);
>              cfg = NULL;
> @@ -991,8 +994,7 @@ static void smmuv3_flush_config(SMMUDevice *sdev)
>      SMMUv3State *s = sdev->smmu;
>      SMMUState *bc = &s->smmu_state;
>  
> -    trace_smmu_config_cache_inv(smmu_get_sid(sdev));
> -    g_hash_table_remove(bc->configs, sdev);
> +    smmu_configs_inv_sdev(bc, sdev);
>  }
>  
>  /* Do translation with TLB lookup. */
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index a31ffcf6e71..bd83648b14c 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -153,6 +153,11 @@ typedef struct SMMUIOTLBKey {
>      uint8_t level;
>  } SMMUIOTLBKey;
>  
> +typedef struct SMMUConfigKey {
> +    SMMUDevice *sdev;
> +    SMMUSecSID sec_sid;
> +} SMMUConfigKey;
> +
>  typedef struct SMMUSIDRange {
>      uint32_t start;
>      uint32_t end;
> @@ -247,6 +252,7 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
>  void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
>  SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
>                                  uint8_t tg, uint8_t level);
> +SMMUConfigKey smmu_get_config_key(SMMUDevice *sdev, SMMUSecSID sec_sid);
>  void smmu_iotlb_inv_all(SMMUState *s);
>  void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid);
>  void smmu_iotlb_inv_vmid(SMMUState *s, int vmid);
> @@ -256,6 +262,7 @@ void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
>  void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
>                          uint64_t num_pages, uint8_t ttl);
>  void smmu_configs_inv_sid_range(SMMUState *s, SMMUSIDRange sid_range);
> +void smmu_configs_inv_sdev(SMMUState *s, SMMUDevice *sdev);
>  /* Unmap the range of all the notifiers registered to any IOMMU mr */
>  void smmu_inv_notifiers_all(SMMUState *s);
>  
> -- 
> 2.34.1
> 

