Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2399C36005
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 02:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txGL0-0007jO-E7; Tue, 25 Mar 2025 22:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1txGKk-0007iM-2U
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 22:17:34 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1txGKh-0005ru-Ug
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 22:17:33 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1742955441; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=S18HT2wI3UvbDW7FmX0ScJ6iw1himhHn4Y3nVgeKmDSDzWj6SWL2QS+IQSIGANdKKRIMODFmwnSWLLpLw2oiadmyZjGRezYfzSFrsC+3RdozwGboCx0CZMgOnA98ZsCKUGCBqgKM7E1roxtHHPE+R0l/MQa0PxOgVJtTR4Wy+W4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1742955441;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=rO0aJmwIt1FtyUhTCeq6crOmo2ad4nWEqGmEitkKXZA=; 
 b=nncJV44eCb3i0+y1XZADYoisfFh3p69i3eQbl16nInJiNE+k+sgYbfkX2u8pGc5wkuWAJA7KDhZir6F2RSo6dqlAilWVHYcujZd/Acoxm0+slgxRHU0eevtvXd5jcrBslTENPD/Zs9dZERixELcs7fpMwOEmeEjlWNHdSkMWdpk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742955441; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=rO0aJmwIt1FtyUhTCeq6crOmo2ad4nWEqGmEitkKXZA=;
 b=HG9H7y8K+UOlpLj77cHjkGGLZOKDwaUylqhSEsMEpv834/OH6nhqfL2tY0CMzwYi
 ychN2dDF7yrEkTotkijqRgxcDpOwrDvuGs0IGvjldeduVl3tuyBjEUrwwshFxGf0tTW
 yymnHZYTijYtzeBiqT3UiI+2CU8uNE1FUsgjVyHc=
Received: by mx.zohomail.com with SMTPS id 17429554397381009.3380613602087;
 Tue, 25 Mar 2025 19:17:19 -0700 (PDT)
Message-ID: <11ccee8d-7378-42d0-878e-91b61affb1cb@collabora.com>
Date: Wed, 26 Mar 2025 05:17:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] ui/console-gl: Add a helper to create a texture
 with linear memory layout
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>
References: <20250325234115.1332883-1-vivek.kasireddy@intel.com>
 <20250325234115.1332883-5-vivek.kasireddy@intel.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20250325234115.1332883-5-vivek.kasireddy@intel.com>
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

On 3/26/25 02:39, Vivek Kasireddy wrote:
> +void surface_gl_create_texture_from_fd(DisplaySurface *surface,
> +                                       int fd, GLuint *texture)
> +{
> +    unsigned long size = surface_stride(surface) * surface_height(surface);
> +    GLuint mem_obj;
> +
> +    if (!epoxy_has_gl_extension("GL_EXT_memory_object") ||
> +        !epoxy_has_gl_extension("GL_EXT_memory_object_fd")) {
> +        return;
> +    }
> +
> +#ifdef GL_EXT_memory_object_fd
> +    glCreateMemoryObjectsEXT(1, &mem_obj);
> +    glImportMemoryFdEXT(mem_obj, size, GL_HANDLE_TYPE_OPAQUE_FD_EXT, fd);
> +    if (!glIsMemoryObjectEXT(mem_obj)) {

This check should always succeed. glGetError() should be used for
glImportMemoryFdEXT() failure checking.

Won't hurt to print error messages instead of failing silently.

-- 
Best regards,
Dmitry

