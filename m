Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DAC7C54FC6
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 02:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJ1MF-0003GY-U7; Sat, 24 May 2025 22:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uJ1MD-0003G6-Pl
 for qemu-devel@nongnu.org; Sat, 24 May 2025 22:45:01 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uJ1MB-0005N0-KQ
 for qemu-devel@nongnu.org; Sat, 24 May 2025 22:45:01 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1748141085; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NRarkR7xvSyyU1xku08B2Fm26U0f8OtoRZ2kOP0w3qYPJjctxHYU+HCXfV0mWfHoIpS86pXlGpaqmLMwso7V87Zpq7hPlJsYLu/DFNFuYaN+buob7HA0SasnN/H1o+x6wHuGUOdnSDGvcDWDHrRF3vjkjtFUUcn5kC49Kple5xw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1748141085;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=VVuQsQVq+XOLYOWwnbLLzWnU4jvuXJ7QKXBr7T4hjHE=; 
 b=J0XreBVWRxWeOjowwcV38ZtkPNzbeE+0lr9d6T0noUVSb+GeNzr7AEidP3OChu0wr2OdfMyWrchB/92sH7+3oYq7ONIbZBcwT9/OKLgINifyCzskTeuRmwG6Fs+BmBlFGRw4dpsu8vPjIoeliuwOqLktnnZqXvQirw66bzN7ccY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1748141084; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=VVuQsQVq+XOLYOWwnbLLzWnU4jvuXJ7QKXBr7T4hjHE=;
 b=Iy70+sAZG+1qxCSZ1jW4VL2a5yO22tBrO1IGZRZrMzmu8D104I/mRL2pWW2oxDlQ
 XLuEe73U/aibZA4+FaoXPN8qylUIopVQqBGljVEk4X9Y4ZVMfmbN6qJxtHv6pmQCLgw
 /Lqz5WMbi83yj+aEi0JUkLNIT6BAMcvu0NlzXoHs=
Received: by mx.zohomail.com with SMTPS id 174814108368150.54071094877554;
 Sat, 24 May 2025 19:44:43 -0700 (PDT)
Message-ID: <4ee99f02-8092-4872-b6b3-e62e2fa83d03@collabora.com>
Date: Sun, 25 May 2025 05:44:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] ui/console-gl: Add a helper to create a texture
 with linear memory layout
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>
References: <20250515024734.758335-1-vivek.kasireddy@intel.com>
 <20250515024734.758335-6-vivek.kasireddy@intel.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20250515024734.758335-6-vivek.kasireddy@intel.com>
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

On 5/15/25 05:45, Vivek Kasireddy wrote:
> +bool surface_gl_create_texture_from_fd(DisplaySurface *surface,
> +                                       int fd, GLuint *texture)
> +{
> +    unsigned long size = surface_stride(surface) * surface_height(surface);
> +    GLenum err = glGetError();
> +    GLuint mem_obj;
> +
> +    if (!epoxy_has_gl_extension("GL_EXT_memory_object") ||
> +        !epoxy_has_gl_extension("GL_EXT_memory_object_fd")) {
> +        return false;
> +    }
> +
> +#ifdef GL_EXT_memory_object_fd
> +    glCreateMemoryObjectsEXT(1, &mem_obj);
> +    glImportMemoryFdEXT(mem_obj, size, GL_HANDLE_TYPE_OPAQUE_FD_EXT, fd);
> +
> +    err = glGetError();
> +    if (err != GL_NO_ERROR) {
> +        error_report("spice: cannot import memory object from fd");
> +        return false;
> +    }

mem_obj should be destroyed on error and when created texture is released

-- 
Best regards,
Dmitry

