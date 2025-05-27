Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B47FC54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 13:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJueZ-0004as-HP; Tue, 27 May 2025 09:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.scherle@rz.uni-freiburg.de>)
 id 1uJueR-0004SA-Aj
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:47:35 -0400
Received: from c1422.mx.srv.dfn.de ([194.95.239.70])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.scherle@rz.uni-freiburg.de>)
 id 1uJueI-00042i-HJ
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 rz.uni-freiburg.de; h=content-transfer-encoding:content-type
 :content-type:in-reply-to:from:from:content-language:references
 :subject:subject:user-agent:mime-version:date:date:message-id
 :received; s=s1; t=1748353559; x=1750167960; bh=3cTh+adArf6y1vf+
 cZo+HaCG4FVNr1MVA9EvhaG1qvk=; b=Y0CDbSc/suzs4qd7guLGbMSERioHayBR
 vZh/sbZxJqo+WIT7YFttx34HNX/2oPYfWUAYkWi9fBEFwPJCxTemx06atiTQ/K3C
 WxMx5Qumyuz8siNpJdiUuyTSLU5p3j/xjqZO+MpmKYasThQch44G4TBFhWPauJXg
 lVfjFwtNUbo=
Received: from fe1.uni-freiburg.de (fe1.uni-freiburg.de [132.230.2.221])
 by c1422.mx.srv.dfn.de (Postfix) with ESMTP id BC7542C0126
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 15:45:58 +0200 (CEST)
Received: from [2001:7c0:2517:20:2d65:91f6:f0da:8564] (account
 michael.scherle@rz.uni-freiburg.de HELO
 [IPV6:2001:7c0:2517:20:2d65:91f6:f0da:8564])
 by mail.uni-freiburg.de (CommuniGate Pro SMTP 6.3.19)
 with ESMTPSA id 47720564; Tue, 27 May 2025 15:45:58 +0200
Message-ID: <dad1dda5-7f56-459a-a744-3ef72e93e0f3@rz.uni-freiburg.de>
Date: Tue, 27 May 2025 15:45:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: RE: [PATCH v4 5/7] ui/console-gl: Add a helper to create a texture
 with linear memory layout
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, "Kim, Dongwon" <dongwon.kim@intel.com>
References: <20250515024734.758335-1-vivek.kasireddy@intel.com>
 <20250515024734.758335-6-vivek.kasireddy@intel.com>
 <7dba8ee4-3af2-4bdb-9edb-df49fea1e842@rz.uni-freiburg.de>
 <746d41f7-4028-4f70-9038-63edf494429b@rz.uni-freiburg.de>
 <IA0PR11MB71855E2B0CCF3D8C1578E5D2F864A@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Language: en-US
From: Michael Scherle <michael.scherle@rz.uni-freiburg.de>
In-Reply-To: <IA0PR11MB71855E2B0CCF3D8C1578E5D2F864A@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.95.239.70;
 envelope-from=michael.scherle@rz.uni-freiburg.de; helo=c1422.mx.srv.dfn.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Vivek,

On 27.05.25 06:20, Kasireddy, Vivek wrote:
> Hi Michael,
> 
>> Subject: Re: [PATCH v4 5/7] ui/console-gl: Add a helper to create a texture
>> with linear memory layout
>>
>> Hi all,
>>
>> I just noticed that Dmitry Osipenko had already pointed out a similar issue
>> earlier-so my message was somewhat redundant. Apologies for the
>> duplication.
> Yeah, looks like you and Dmitry identified the leak independently, almost at the
> same time.
> 
>>
>> Also, I made a small mistake in the patch I proposed:
>> The call to glDeleteMemoryObjectsEXT(1, &mem_obj); should be placed
>> above the #endif, not after it. Sorry about that oversight!
> Your patch from Open Source VDI repo seems like a better solution, so, I'll add it
> to this series and send it out for review in v5. Please add description/commit message
> and your signed-off-by line to it.
> 

Thanks! I’ve added it and made a few additional adjustments here:
https://gitlab.uni-freiburg.de/opensourcevdi/qemu/-/commit/859d500761b35cc785fcadd9d554a78712309e88

Feel free to merge it into your patches if you want.

Best regards,
Michael

> Thanks,
> Vivek
> 
>>
>> Best regards,
>> Michael
>>
>>
>> On 26.05.25 15:06, Michael Scherle wrote:
>>> Great to see this patch making progress.
>>>
>>> I've tested it extensively, and unfortunately, I've noticed a memory
>>> leak in surface_gl_create_texture_from_fd(). The memory leak is hard
>>> to see since the memory is owned by the gpu driver.
>>> On Intel hardware, it's possible to observe the leak using:
>>>
>>> cat /sys/module/i915/refcnt
>>> or
>>> xpu-smi ps
>>>
>>> In on of my use case-which involves frequent scanout disable/enable
>>> cycles-the leak is quite apparent. However, in more typical scenarios,
>>> it might be difficult to catch.
>>>
>>> The issue stems from the mem_obj not being deleted after use. I've put
>>> together a minimal modification to address it:
>>>
>>>
>>>
>>> On 15.05.25 04:45, Vivek Kasireddy wrote:
>>>> There are cases where we do not want the memory layout of a texture
>>>> to be tiled as the component processing the texture would not know
>>>> how to de-tile either via software or hardware. Therefore, ensuring
>>>> that the memory backing the texture has a linear layout is absolutely
>>>> necessary in these situations.
>>>>
>>>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>>>> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>>> Cc: Frediano Ziglio <freddy77@gmail.com>
>>>> Cc: Dongwon Kim <dongwon.kim@intel.com>
>>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>>>> ---
>>>>    include/ui/console.h |  2 ++
>>>>    ui/console-gl.c      | 32 ++++++++++++++++++++++++++++++++
>>>>    2 files changed, 34 insertions(+)
>>>>
>>>> diff --git a/include/ui/console.h b/include/ui/console.h index
>>>> 46b3128185..5cfa6ae215 100644
>>>> --- a/include/ui/console.h
>>>> +++ b/include/ui/console.h
>>>> @@ -422,6 +422,8 @@ bool
>>>> console_gl_check_format(DisplayChangeListener
>>>> *dcl,
>>>>                                 pixman_format_code_t format);
>>>>    void surface_gl_create_texture(QemuGLShader *gls,
>>>>                                   DisplaySurface *surface);
>>>> +bool surface_gl_create_texture_from_fd(DisplaySurface *surface,
>>>> +                                       int fd, GLuint *texture);
>>>>    void surface_gl_update_texture(QemuGLShader *gls,
>>>>                                   DisplaySurface *surface,
>>>>                                   int x, int y, int w, int h); diff
>>>> --git a/ui/console-gl.c b/ui/console-gl.c index
>>>> 103b954017..97f7989651 100644
>>>> --- a/ui/console-gl.c
>>>> +++ b/ui/console-gl.c
>>>> @@ -25,6 +25,7 @@
>>>>     * THE SOFTWARE.
>>>>     */
>>>>    #include "qemu/osdep.h"
>>>> +#include "qemu/error-report.h"
>>>>    #include "ui/console.h"
>>>>    #include "ui/shader.h"
>>>> @@ -96,6 +97,37 @@ void surface_gl_create_texture(QemuGLShader *gls,
>>>>        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER,
>>>> GL_LINEAR);
>>>>    }
>>>> +bool surface_gl_create_texture_from_fd(DisplaySurface *surface,
>>>> +                                       int fd, GLuint *texture) {
>>>> +    unsigned long size = surface_stride(surface) *
>>>> surface_height(surface);
>>>> +    GLenum err = glGetError();
>>>> +    GLuint mem_obj;
>>>
>>> +    GLuint mem_obj = 0;
>>>
>>>> +
>>>> +    if (!epoxy_has_gl_extension("GL_EXT_memory_object") ||
>>>> +        !epoxy_has_gl_extension("GL_EXT_memory_object_fd")) {
>>>> +        return false;
>>>> +    }
>>>> +
>>>> +#ifdef GL_EXT_memory_object_fd
>>>> +    glCreateMemoryObjectsEXT(1, &mem_obj);
>>>> +    glImportMemoryFdEXT(mem_obj, size,
>> GL_HANDLE_TYPE_OPAQUE_FD_EXT,
>>>> fd);
>>>> +
>>>> +    err = glGetError();
>>>> +    if (err != GL_NO_ERROR) {
>>>
>>> +          if (mem_obj) {
>>> +              glDeleteMemoryObjectsEXT(1, &mem_obj);
>>> +          }
>>>
>>>> +        error_report("spice: cannot import memory object from fd");
>>>> +        return false;
>>>> +    }
>>>> +
>>>> +    glGenTextures(1, texture);
>>>> +    glBindTexture(GL_TEXTURE_2D, *texture);
>>>> +    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_TILING_EXT,
>>>> GL_LINEAR_TILING_EXT);
>>>> +    glTexStorageMem2DEXT(GL_TEXTURE_2D, 1, GL_RGBA8,
>>>> surface_width(surface),
>>>> +                         surface_height(surface), mem_obj, 0);
>>>> +#endif
>>>
>>> +    glDeleteMemoryObjectsEXT(1, &mem_obj);
>>>
>>>> +    return *texture > 0 && glGetError() == GL_NO_ERROR; }
>>>> +
>>>>    void surface_gl_update_texture(QemuGLShader *gls,
>>>>                                   DisplaySurface *surface,
>>>>                                   int x, int y, int w, int h)
>>>
>>>
>>>
>>> That said, my OpenGL knowledge is somewhat limited, and the
>>> documentation wasn't entirely clear to me on whether deleting the
>>> memory object while the texture is still being used, is always safe.
>>> Based on a quick look at the iris and llvmpipe implementations, it
>>> appears to be acceptable.
>>>
>>> If that's not the case, an alternative fix could follow this approach
>>> instead: https://gitlab.uni-freiburg.de/opensourcevdi/qemu/-/
>>> commit/4ca806871c141089be16af25c1820d3e04f3e27d
>>>
>>> Greetings Michael
> 


