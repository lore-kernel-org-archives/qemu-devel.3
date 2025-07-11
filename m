Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0F0C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDzl-0006Mb-JF; Fri, 11 Jul 2025 09:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uaDy6-0001dM-Jy
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:39:23 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uaDy4-0005Cx-CJ
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:39:14 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1752241124; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZHxmBdV4OrVTUanJbbrWZzgn77ZpQYV2luL2vtMxaJR+DKpwwX3ggRivCaPbWr9CeXvfHH7FsGC6KqKmGoFt4AK/t2MvhT1RVfK9S5imY1miHTucaw1vfLSCIbUa/rEvIIKjwg68zSG+6nH1KD1ElDi8qyz7ljT5l08FuKgQxGg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1752241124;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=OaMBKn7bwbEDgZXeHuvC/fjkyo6uHl7rCjfnAyq4b+g=; 
 b=UNat9mWHSGfRz0davO2W69JgE+UJZG7ks0ghOI65RwEnBAnv3udhU3uKE2SrZoMtSFaezm9rZ9HThhZhVzCr31e9jTTHXQBqvCKZ/2CTE8WroE+tV6VcS26C/iVbFrn1TNdaSPdmqXLKObWgcvS5XJZ4CVGHtFIM/itiCfW4lG8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752241124; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=OaMBKn7bwbEDgZXeHuvC/fjkyo6uHl7rCjfnAyq4b+g=;
 b=dR/RQKfLG/9DaXvGMmgl9W3bulLHFG3277B+NyW5mvFp0pI1RR74/RPUev1wrWhb
 LLsWTz29lpGXYEmUCIEIL78G0EVO2t9AorNRvkIYMXgtXx/ri7sCh0e+cLKD21QciKV
 uOeHQzlauqArMyGPeaWw9wzaHKtG3DW+wkR7zfqY=
Received: by mx.zohomail.com with SMTPS id 1752241121332688.5794301027861;
 Fri, 11 Jul 2025 06:38:41 -0700 (PDT)
Message-ID: <9ec61f6e-4ad9-4693-867a-0b0780b039dc@collabora.com>
Date: Fri, 11 Jul 2025 16:38:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/7] ui/console-gl: Add a helper to create a texture
 with linear memory layout
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>,
 Michael Scherle <michael.scherle@rz.uni-freiburg.de>
References: <20250617043546.1022779-1-vivek.kasireddy@intel.com>
 <20250617043546.1022779-6-vivek.kasireddy@intel.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20250617043546.1022779-6-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 6/17/25 07:32, Vivek Kasireddy wrote:
> There are cases where we do not want the memory layout of a texture to
> be tiled as the component processing the texture would not know how to
> de-tile either via software or hardware. Therefore, ensuring that the
> memory backing the texture has a linear layout is absolutely necessary
> in these situations.
> 
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Frediano Ziglio <freddy77@gmail.com>
> Cc: Dongwon Kim <dongwon.kim@intel.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Co-developed-by: Michael Scherle <michael.scherle@rz.uni-freiburg.de>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>  include/ui/console.h |  3 +++
>  ui/console-gl.c      | 48 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+)
> 
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 46b3128185..98feaa58bd 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -422,6 +422,9 @@ bool console_gl_check_format(DisplayChangeListener *dcl,
>                               pixman_format_code_t format);
>  void surface_gl_create_texture(QemuGLShader *gls,
>                                 DisplaySurface *surface);
> +bool surface_gl_create_texture_from_fd(DisplaySurface *surface,
> +                                       int fd, GLuint *texture,
> +                                       GLuint *mem_obj);
>  void surface_gl_update_texture(QemuGLShader *gls,
>                                 DisplaySurface *surface,
>                                 int x, int y, int w, int h);
> diff --git a/ui/console-gl.c b/ui/console-gl.c
> index 103b954017..afb36dba64 100644
> --- a/ui/console-gl.c
> +++ b/ui/console-gl.c
> @@ -25,6 +25,7 @@
>   * THE SOFTWARE.
>   */
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "ui/console.h"
>  #include "ui/shader.h"
>  
> @@ -96,6 +97,53 @@ void surface_gl_create_texture(QemuGLShader *gls,
>      glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
>  }
>  
> +bool surface_gl_create_texture_from_fd(DisplaySurface *surface,
> +                                       int fd, GLuint *texture,
> +                                       GLuint *mem_obj)
> +{
> +    unsigned long size = surface_stride(surface) * surface_height(surface);
> +    GLenum err = glGetError();
> +    *texture = 0;
> +    *mem_obj = 0;
> +
> +    if (!epoxy_has_gl_extension("GL_EXT_memory_object") ||
> +        !epoxy_has_gl_extension("GL_EXT_memory_object_fd")) {
> +        error_report("spice: required OpenGL extensions not supported: "
> +                     "GL_EXT_memory_object and GL_EXT_memory_object_fd");
> +        return false;
> +    }
> +
> +#ifdef GL_EXT_memory_object_fd
> +    glCreateMemoryObjectsEXT(1, mem_obj);
> +    glImportMemoryFdEXT(*mem_obj, size, GL_HANDLE_TYPE_OPAQUE_FD_EXT, fd);
> +
> +    err = glGetError();
> +    if (err != GL_NO_ERROR) {
> +        error_report("spice: cannot import memory object from fd");
> +        goto cleanup_mem;
> +    }
> +
> +    glGenTextures(1, texture);
> +    glBindTexture(GL_TEXTURE_2D, *texture);
> +    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_TILING_EXT, GL_LINEAR_TILING_EXT);
> +    glTexStorageMem2DEXT(GL_TEXTURE_2D, 1, GL_RGBA8, surface_width(surface),
> +                         surface_height(surface), *mem_obj, 0);
> +    err = glGetError();
> +    if (err != GL_NO_ERROR) {
> +        error_report("spice: cannot create texture from memory object");
> +        goto cleanup_tex_and_mem;
> +    }
> +    return true;
> +
> +cleanup_tex_and_mem:
> +    glDeleteTextures(1, texture);
> +cleanup_mem:
> +    glDeleteMemoryObjectsEXT(1, mem_obj);
> +
> +#endif
> +    return false;
> +}
> +
>  void surface_gl_update_texture(QemuGLShader *gls,
>                                 DisplaySurface *surface,
>                                 int x, int y, int w, int h)

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry

