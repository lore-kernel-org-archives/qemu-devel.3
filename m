Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358BEC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 11:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9itW-0003r5-Ij; Tue, 29 Apr 2025 07:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1u9itS-0003qZ-Bm
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 07:12:56 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1u9itP-0005JF-9B
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 07:12:53 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1745925160; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Dzdtwvp5BZVRiXrcmOcKW1zbaaYRrKF63KGqMytKNp+EuZNbQ9lZf2SWkBrhe7TCagIeilNkETLjAMDa4ef9y5Bd/Wcgw5VitwRuMJHIyiOsF2XajDM3LTSqBvluooxhEitf5ClrF6znl9hT+CMLRctWPQlOlObu9sShKGjWFM8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1745925160;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=VNKGKFZFAiAUmSxq2iIlB8GWf3C3ODpX4M/66HHlL+M=; 
 b=DGGSV84IcgiFSZlzIFlT6XwHQiOnZfeksZqZAehgycPT1D6H8n7LRgGiUG8VMMrZEW1TF22ph6q+yCcbMsKMw5rLjcHQmXgLFsGiuuO3GCJyUjYrNZEcMr8+zP62Fc78rr+gljlc6ijAideyu7lo7p5ombcbH5fEikVCSlD9GK4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745925160; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=VNKGKFZFAiAUmSxq2iIlB8GWf3C3ODpX4M/66HHlL+M=;
 b=CafzlWdSO8qKy5bp4+LcZj56wnQX5TZkJOFDjMNZL0MwPbWsNwqRt9Qc9Z/64qiC
 vGm+yrl4CKEDF3KG5BaglNKrXi7c85TT5DgdKSb48klevI+0faRZJv08RKQKzzzIIoD
 Gfutlh+iuU1pCoDM9D1QDz8PpKozlJI7QSlkiBjE=
Received: by mx.zohomail.com with SMTPS id 1745925157331788.783333040304;
 Tue, 29 Apr 2025 04:12:37 -0700 (PDT)
Message-ID: <5b6404dd-7b33-4960-820e-628eb0de0960@collabora.com>
Date: Tue, 29 Apr 2025 14:12:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] ui/console-gl: Add a helper to create a texture
 with linear memory layout
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>
References: <20250429060952.59508-1-vivek.kasireddy@intel.com>
 <20250429060952.59508-5-vivek.kasireddy@intel.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20250429060952.59508-5-vivek.kasireddy@intel.com>
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

On 4/29/25 09:08, Vivek Kasireddy wrote:
> +#ifdef GL_EXT_memory_object_fd
> +    glCreateMemoryObjectsEXT(1, &mem_obj);
> +    glImportMemoryFdEXT(mem_obj, size, GL_HANDLE_TYPE_OPAQUE_FD_EXT, fd);
> +    if (glGetError() != GL_NO_ERROR) {
> +        error_report("spice: cannot import memory object from fd");
> +        return;
> +    }

glGetError() retains error once error occurred. Calling glGetError()
returns last error code and clears the error state. Hence you should add
a dummy glGetError() call before glCreateMemoryObjectsEXT() to clear the
potential stale GL errors, otherwise your code will handle unrelated GL
errors and report them as memfd import failures.

-- 
Best regards,
Dmitry

