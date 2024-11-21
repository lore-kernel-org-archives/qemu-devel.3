Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7338ED75BDF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 09:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE3bI-000415-Lg; Thu, 21 Nov 2024 04:35:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tE3bG-00040H-Di
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 04:35:46 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tE3bE-0001hl-Qs
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 04:35:46 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43161e7bb25so5451345e9.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 01:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732181743; x=1732786543; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LE0e61149vp67X42KPB5FHWjES7wbRhgUMCa1aZ9hCg=;
 b=KIxc6agR/MaorS5+WTEMj9GEBYGTRExt7EZHw1Sge8KCbgt0NFV3oeq5urpMDXUkVx
 o8fwSNHTQ3JNRDs3ORTkF509b8n+ToYkfq2moXTyhRWRzORRVCZ6G3pfrk/3ERVDcHgA
 N3b0rCEnFOmsODhj83atp6NVjCHeh69RXxWyvhv6n0inJKkZ09TfE+QDBJdg1l8Ocm+X
 1H5WbrvKMuMZKhCvpzs9TWJmVNEi+Taze3UtP4qjmDiPEQOXqE0/LA6PNjixpGH2PVrN
 3bFRXMDyTBP6kZ6EtP3ERQXnbbxVB0K/s+gRKVfVhflQ0L//1+DzJWC0B4fIQcbpt0S7
 +1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732181743; x=1732786543;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LE0e61149vp67X42KPB5FHWjES7wbRhgUMCa1aZ9hCg=;
 b=g9gGEUZv8i0I22r7TpSzCCsM/NO8DawKEExY/naTPxFzbi/8QVhEnZpjKK/3rr//EP
 NkiIhSHalaG3E2QJKuUMRaebdz6Q3dTjqBFDyjVf9TQSGpq5Vn10j+35MOJ1tFWT4SaK
 2fZQKHbfoDSFWsvZkjuaNZwz18RUwrcC0Qlwq/fS2ZfmIghkJ0VrCfXw54Uc4ZKTSH9F
 v8HzlhdheFJJnuU2SzHh7+AOX0VgzZiuc4rku7unj8FjD1cKtr5IVGHP63BJMi4X4sHT
 o0frdGPItDEt0JuSMeZucUnevOOA5H9QxjXMTUvHyo3WVHCm/fmsSuOg/mtGzNCRa3jn
 zJxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/FPMHfUI8NPzAdHheEy4k+hdB9xbv2MqjOsBc0HTXfj573GW0+Ox6SHPFtPeSS680bqkwpf512Fz+@nongnu.org
X-Gm-Message-State: AOJu0YwhS3J++hvSQ2QZynxUFN3JoO6rfy7tCwNmtvygabdSpaEp5QES
 FF+hcf67zCO8F+aHjuhLEpdo4od84fpx6hMDKm/y1yrxDGK+Sr726EejNjDDhys=
X-Google-Smtp-Source: AGHT+IHz8MtXcweZXqQ3KPqLQdRaOK3BIZY/nEkvsr9x9M+tbLEfL8mptjavFfT6XMAQXMOpIWEDHQ==
X-Received: by 2002:a05:600c:444f:b0:431:58cd:b260 with SMTP id
 5b1f17b1804b1-4334f01815emr48440285e9.25.1732181742930; 
 Thu, 21 Nov 2024 01:35:42 -0800 (PST)
Received: from [192.168.69.146] ([176.187.204.90])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b46172e1sm47481145e9.24.2024.11.21.01.35.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 01:35:42 -0800 (PST)
Message-ID: <66301003-f2cd-4a0a-8951-cbfdcb1c398b@linaro.org>
Date: Thu, 21 Nov 2024 10:35:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] hw/ppc: Explicitly create the drc container
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
References: <20241120215703.3918445-1-peterx@redhat.com>
 <20241120215703.3918445-7-peterx@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241120215703.3918445-7-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Hi Peter,

On 20/11/24 22:56, Peter Xu wrote:
> QEMU will start to not rely on implicit creations of containers soon.  Make
> PPC drc devices follow by explicitly create the container whenever a drc
> device is realized, dropping container_get() calls.
> 
> No functional change intended.
> 
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/ppc/spapr_drc.c | 40 ++++++++++++++++++++++++++++++----------
>   1 file changed, 30 insertions(+), 10 deletions(-)


> +static GOnce drc_container_created = G_ONCE_INIT;
> +
> +static gpointer drc_container_create(gpointer unused G_GNUC_UNUSED)
> +{
> +    container_create(object_get_root(), DRC_CONTAINER_PATH);
> +    return NULL;
> +}
> +
> +static Object *drc_container_get(void)
> +{
> +    return object_resolve_path_component(
> +        object_get_root(), DRC_CONTAINER_PATH);
> +}
> +
> +/* TODO: create the container in an ppc init function */
> +static void drc_container_create_once(void)
> +{
> +    g_once(&drc_container_created, drc_container_create, NULL);
> +}
> +
>   static void drc_realize(DeviceState *d, Error **errp)
>   {
>       SpaprDrc *drc = SPAPR_DR_CONNECTOR(d);
> @@ -521,6 +541,9 @@ static void drc_realize(DeviceState *d, Error **errp)
>       Object *root_container;
>       const char *child_name;
>   
> +    /* Whenever a DRC device is realized, create the container */
> +    drc_container_create_once();

Can't we just create it once in spapr_dr_connector_class_init(),
removing the G_ONCE_INIT need?

>       trace_spapr_drc_realize(spapr_drc_index(drc));
>       /* NOTE: we do this as part of realize/unrealize due to the fact
>        * that the guest will communicate with the DRC via RTAS calls
> @@ -529,7 +552,7 @@ static void drc_realize(DeviceState *d, Error **errp)
>        * inaccessible by the guest, since lookups rely on this path
>        * existing in the composition tree
>        */
> -    root_container = container_get(object_get_root(), DRC_CONTAINER_PATH);
> +    root_container = drc_container_get();
>       child_name = object_get_canonical_path_component(OBJECT(drc));
>       trace_spapr_drc_realize_child(spapr_drc_index(drc), child_name);
>       object_property_add_alias(root_container, link_name,


