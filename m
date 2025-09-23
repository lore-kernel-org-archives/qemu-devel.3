Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CC1CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 09:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0zIz-0004oj-6f; Tue, 23 Sep 2025 05:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0zIu-0004nV-Ro
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:27:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0zIo-0003L0-Pd
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758619631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jSKBLcpmzS//805LXRLj8uu85TSSSxReX/pgf/5N0Zc=;
 b=f0lN/gu6RE2a1uC3Exn+YTvmIECUWejL1A5n6euO6xSiu8FrjLO1Z4iJ/UI5JFybbMGwTv
 50DYEvKnbVTIaUO0t40M8nHyM8dwaDVPWEs3gykiQdtWlGRbr5zUmnCRMCe3LP+K9eWTCC
 WkmT6fM94yxTV9wDXheoH/cChDpggss=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-VBXYY7VzNWGj_Uykq7ogjA-1; Tue, 23 Sep 2025 05:27:10 -0400
X-MC-Unique: VBXYY7VzNWGj_Uykq7ogjA-1
X-Mimecast-MFC-AGG-ID: VBXYY7VzNWGj_Uykq7ogjA_1758619629
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b25f63db20bso255678366b.0
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 02:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758619629; x=1759224429;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jSKBLcpmzS//805LXRLj8uu85TSSSxReX/pgf/5N0Zc=;
 b=cfqRGIHnMJyDDH5Chv1j42eRVDoXlJG4g0zOUoUSMPOmLax7WB8ve3GE7+BSMZ/efI
 7DRKQ8s+I+6dA+T08j5RvjDQdmygi5jQNTMI5FXlnjMTw/J8IpEHSVbEFyfcJSoCbJ04
 B8YhoTZvkRIT1iSQfzyANOpCsxCV81CjHQnFTkP3vic875/34ACPR2SiHGw3trDNGnRF
 9vvd04E1cwvD5J4lyRLMzxLZybNpkzNrWyDov2EMPh0/qH5eTceosh6u2z38hGnmQhmp
 z+/0tERkU2BEcTnN67Nr9qTXjntzXcymoYJQ6tjN055y9yzPbMhkoGWG4pydNK9P0Eea
 ct5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMFhKB+XtPHpn2w7pKLe1WG6KB2Nqr1/MaHgqEOBys3uuZ5SH9VybCZABJLnYr7OnDn7O4G0htuwC2@nongnu.org
X-Gm-Message-State: AOJu0YyesTWdkEeEcGvY5sr7DU24f9iPiFDo5I9e9iPIWcnZHcGiKzwT
 i30J87vRmYr5V90ay2DiqDtM9RivsmfUhRa9VM/iTDH9GLjECWTgpyIdl4L2ucMSkUwvxE/5BZ3
 Rcvk9VHHT1/nSunGzTWkknXbCTd6RjgkpM9OtHNgtgqyKpsyVXBnalJP6
X-Gm-Gg: ASbGncvrL7pBlo9OGH6htiB86PUgTtMY74AwRwdFH1uVDGJ2pWna82j678QHTXlHADX
 BZ3P/RQ8QvS25SL9jg7fews4HrrUo3f0vvh5AoSdm6eMjeYfzgF78fVbIw2f5+0oTEy9NWuthTL
 Df0fVnBguYN5RyYowH+/X+fo91ihcjWDsxSUo296pSEOCyDk8GhOFBqtjKm5DaRbT6slvmc1jGi
 7IuMj+34zoCyKixDs5+xTBmAeXzqvoKuHP5R+p7al99zpieABgBMzpngXAfZIUfUbvF/dCmzoGs
 5uOEwCQUxXqqKQzrziTwqC5Yqu52FP+PnWr8G3Lg8izFeXXrvBZIleuurxUxFDo9yCfHNrkEN9J
 aAYwAiDSM91kSI8+p43VQHI4Ngt7aDodZcjqeyvzgWAKE8Q==
X-Received: by 2002:a17:906:6a03:b0:b07:87f1:fc42 with SMTP id
 a640c23a62f3a-b301c9491admr206134066b.16.1758619629047; 
 Tue, 23 Sep 2025 02:27:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF+JYqT1To/ahkFj77XE12K5uq42Acl36tC17kw0Cnb9aYtKff0l4SVZ9TfidipoTsyvqikg==
X-Received: by 2002:a17:906:6a03:b0:b07:87f1:fc42 with SMTP id
 a640c23a62f3a-b301c9491admr206131566b.16.1758619628552; 
 Tue, 23 Sep 2025 02:27:08 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b28fc68e7d5sm711752266b.105.2025.09.23.02.27.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 02:27:07 -0700 (PDT)
Message-ID: <2ad14a16-b7ab-4e13-995a-99ef470a6cb7@redhat.com>
Date: Tue, 23 Sep 2025 11:27:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] qom: Do not finalize twice
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20250906-mr-v2-0-2820f5a3d282@rsg.ci.i.u-tokyo.ac.jp>
 <20250906-mr-v2-1-2820f5a3d282@rsg.ci.i.u-tokyo.ac.jp>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250906-mr-v2-1-2820f5a3d282@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 9/6/25 04:39, Akihiko Odaki wrote:
> The next change adds code to retain references from an object to the
> parent when it is being unparented to ensure that the parent outlive
> them. This change handles the following scenario with the code:
> 
> 1. The parent starts being finalized without unparenting.
> 2. Unparenting happens during finalization.
> 3. The child retains the reference to the parent.
> 4. The child gets finalized, and releases the reference.
> 
> In this scenario, the reference counter of the parent reaches to zero,
> gets incremented, and gets decremented to reach to zero again. This
> change ensures that finalization will be triggered again in the
> scenario.
> 
> Note that the reference counter needs to reach to zero again before
> finalization ends; otherwise the object will be "resurrected", which
> is not clearly defined and prohibited with an existing assertion.
> 
> One thing that looks concerning with this change is that it adds a bool
> to Object. This is not a problem in the most situations where the host
> uses 64-bit addressing because the member is added to a gap needed for
> alignment, and possible double-free scenarios handled with this change
> are more serious than the extra memory usage for 32-bit hosts.

If this is a problem, we could reserve a special value of ->ref for that 
(such as bit 31) but I think this is okay as long as there is this 
32-bit hole.

Paolo

> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   include/qom/object.h | 1 +
>   qom/object.c         | 5 +++++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 26df6137b911..7f7b1ffea8fe 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -158,6 +158,7 @@ struct Object
>       ObjectFree *free;
>       GHashTable *properties;
>       uint32_t ref;
> +    bool finalizing;
>       Object *parent;
>   };
>   
> diff --git a/qom/object.c b/qom/object.c
> index 1856bb36c74c..b766b2e9baa7 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -725,6 +725,11 @@ static void object_finalize(void *data)
>       Object *obj = data;
>       TypeImpl *ti = obj->class->type;
>   
> +    if (obj->finalizing) {
> +        return;
> +    }
> +
> +    obj->finalizing = true;
>       object_property_del_all(obj);
>       object_deinit(obj, ti);
>   
> 


