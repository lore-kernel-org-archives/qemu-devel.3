Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB42C531E1
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 22:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtCzD-0005Il-JS; Thu, 19 Feb 2026 17:59:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vtCzC-0005IW-3R
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 17:59:06 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vtCzA-00016Z-1S
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 17:59:05 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1771541917; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VMrSc2P2LnrhynBZwg5r02o+10H2cvQ0lc4AS7CJ9jZFh4uTDPiI5M71rLPxN/q99nMrKwweW0SqkKEWcEAzjRP8DOjQTr+Jjk1RBnhfI28YdAFwkutAalqxILsJrRgOE828ysxezjQ9oMjgasLA7RSh13JeupiB8avs6EhHtWE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1771541917;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Xn72N2s8UxSQsJ9UsxAuInbn4yCHGbJ6yk+Lus8JHhA=; 
 b=niYNvxXwZqLK0BjWYeQDqfzZmk/eTh0gz8Xa6mI3GQG/PFIjuCcabIHY8RX3dzUuAIGGj0h8e8AdswEJpOz3oOTpCYMU4H3UMXw4IJYF6F9j7UM6tGBL4g0aI6P6d548/bwlb5T36SOJvJrCiEoBn1AEDCCCZpcygt6LgXyViuo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771541917; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=Xn72N2s8UxSQsJ9UsxAuInbn4yCHGbJ6yk+Lus8JHhA=;
 b=Fn8lKB8SCkGIbE4x8KTCHlmnI7ZgSySI8jUuzx5sIWEHzLk7i9rDsJi46t9qt+4t
 JjJVnHEeXd10pNKKQWysLkN9mzckgF/OMQU7Z7OtOTqpElgELmzh3NKWPxDdYj0UVIg
 JcuPLmB25eoiBpVJ4TSS+upmiua6ivzuNc1YlHng=
Received: by mx.zohomail.com with SMTPS id 177154191598682.37679392682412;
 Thu, 19 Feb 2026 14:58:35 -0800 (PST)
Message-ID: <34da4235-a78d-4d89-beeb-616e821918a4@collabora.com>
Date: Fri, 20 Feb 2026 01:58:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 01/19] ui/sdl2: Restore original context after new
 context creation
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yiwei Zhang <zzyiwei@gmail.com>, Sergio Lopez Pascual <slp@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Robert Beckett <bob.beckett@collabora.com>
References: <20260217214928.2970885-1-dmitry.osipenko@collabora.com>
 <20260217214928.2970885-2-dmitry.osipenko@collabora.com>
 <080bcab2-6f4a-43bc-b62f-64447f0f3eb7@rsg.ci.i.u-tokyo.ac.jp>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <080bcab2-6f4a-43bc-b62f-64447f0f3eb7@rsg.ci.i.u-tokyo.ac.jp>
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

Hello Akihiko,

On 2/18/26 10:02, Akihiko Odaki wrote:
> On 2026/02/18 6:49, Dmitry Osipenko wrote:
>> SDL API changes GL context to a newly created GL context, which differs
>> from other GL providers that don't switch context. Change SDL backend to
>> restore the original GL context. This allows Qemu's virtio-gpu to support
>> new virglrenderer async-fencing feature for Virgl contexts, otherwise
>> virglrenderer's vrend creates a fence-sync context on the Qemu's
>> main-loop thread that erroneously stays in-use by the main-loop after
>> creation, not allowing vrend's fence-sync thread switch to this new
>> context that belongs to it.
>>
>> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>> Tested-by: Alex Bennée <alex.bennee@linaro.org>
>> Acked-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>> Reviewed-by: Yiwei Zhang <zzyiwei@gmail.com>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>   ui/sdl2-gl.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
>> index 3be17d1079af..ea2301305d3e 100644
>> --- a/ui/sdl2-gl.c
>> +++ b/ui/sdl2-gl.c
>> @@ -168,6 +168,9 @@ QEMUGLContext sdl2_gl_create_context(DisplayGLCtx
>> *dgc,
>>                               SDL_GL_CONTEXT_PROFILE_ES);
>>           ctx = SDL_GL_CreateContext(scon->real_window);
>>       }
>> +
>> +    SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
> 
> Looking at this patch now, I think this should pass NULL instead of
> scon->winctx instead. The patch message says it restores "the original
> GL context", but with all the "unset context after GL operations"
> patches, no context should be bound. As those patches do, this should
> also unset the context and prevent a thread from keeping holding the
> context.

The gl_create_context() is invoked by virglrender while vrend performs
GL, not while QEMU performs GL. Unbinding ctx feels like irrelevant
behaviour in a case of vrend, since vrend creates new GL ctx and
continues to perform GL operations - hence ctx shouldn't be unbound in
case of vrend.

Better will be to get current bound GL context at the beginning of
gl_create_context() and restore it at the end. This will work reasonably
for both QEMU and vrend cases, where in case of QEMU performing GL
internally the restored ctx will be NULL.

Will change it in v19 and improve the func naming + terminology. Thanks
for the review.

-- 
Best regards,
Dmitry

