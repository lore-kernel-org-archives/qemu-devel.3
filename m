Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C48C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaECb-0004Uq-B0; Fri, 11 Jul 2025 09:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uaE8p-0005PG-Gc
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:50:19 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uaE8n-0002CZ-Jc
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:50:19 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1752241796; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mv0183sZ8SB3K4bMZkCIB5gBl2NmM68T+ZPSxtytdprUHJTeahoajhftARsY7zardGM4oOY5WxAmtqKnjiJaaf9sqbtwcEqnBsIuAY9eH3wtmFxIFq+ddeMifoqyowUY+n5zhRbKqRKG+BY9yJSj/V64m4zEjmHwur3ZXS8Uqxs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1752241796;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=4xKoTmshrs5EbgTVQQ27zvnayNHxatWYKdti2Xs5BZo=; 
 b=anfzNIQ0lL7I6yo9VQM7nWu3YEGERjlFIQkz0YVRvvZ0ezs+Ei20FzpWRh8u8g15NGOOI8WHPF3YKlstcTOQ8TW7aymhmZejhGHqFze0W5DzBUbYajEUohkUuPcmYPaOSyEXOl3V5YZ1CIlF81Oh2yo2caXvreKrsNMHy1fh+ek=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752241796; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=4xKoTmshrs5EbgTVQQ27zvnayNHxatWYKdti2Xs5BZo=;
 b=iyaoeB2eVbCv+iQDlNE6aexAfK9HOolWhQ5P2IhaWiasxP4hRygP43VJqZGkZhj0
 h8gv5PCljbq21yXlwXR4STmM9FT2l9JqFQFkMje9lF321G1R00BuMdPMjGpLkvrQ1Wt
 21NhSQFU0yvfbNkRFlqI6VzmrBwliBnMzNXWkAR4=
Received: by mx.zohomail.com with SMTPS id 17522417952341023.9547764229617;
 Fri, 11 Jul 2025 06:49:55 -0700 (PDT)
Message-ID: <441589cc-cdf1-43e9-a9fc-d5064ef3ea42@collabora.com>
Date: Fri, 11 Jul 2025 16:49:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/7] ui/spice: Create a new texture with linear layout
 when gl=on is specified
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>,
 Michael Scherle <michael.scherle@rz.uni-freiburg.de>
References: <20250617043546.1022779-1-vivek.kasireddy@intel.com>
 <20250617043546.1022779-7-vivek.kasireddy@intel.com>
 <8f8eae1b-4a43-45ed-b748-66a364b1cc8d@collabora.com>
Content-Language: en-US
In-Reply-To: <8f8eae1b-4a43-45ed-b748-66a364b1cc8d@collabora.com>
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

On 7/11/25 16:46, Dmitry Osipenko wrote:
> On 6/17/25 07:32, Vivek Kasireddy wrote:
>> diff --git a/ui/console-gl.c b/ui/console-gl.c
>> index afb36dba64..403fc36fbd 100644
>> --- a/ui/console-gl.c
>> +++ b/ui/console-gl.c
>> @@ -184,6 +184,12 @@ void surface_gl_destroy_texture(QemuGLShader *gls,
>>      }
>>      glDeleteTextures(1, &surface->texture);
>>      surface->texture = 0;
>> +#ifdef GL_EXT_memory_object_fd
>> +    if (surface->mem_obj) {
>> +        glDeleteMemoryObjectsEXT(1, &surface->mem_obj);
>> +        surface->mem_obj = 0;
>> +    }
> 
> Nit: spec says that deleting surface->mem_obj=0 is ignored, hence the
> "if (surface->mem_obj)" check shouldn't be needed, like in a case with
> glDeleteTextures() above. That would make code look more consistent.
> 

Otherwise looks fine

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry

