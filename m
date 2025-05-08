Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95399C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 11:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCzFr-0002j3-4M; Thu, 08 May 2025 07:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCzFn-0002in-6n
 for qemu-devel@nongnu.org; Thu, 08 May 2025 07:17:27 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCzFk-0003Y2-PC
 for qemu-devel@nongnu.org; Thu, 08 May 2025 07:17:26 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-72c7332128eso502916a34.0
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 04:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746703043; x=1747307843; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=879OmmlA3sgGXrbvdNOEjTeqe65pLc26GZ0oXu9+SWw=;
 b=mNtm98K/SwOCfv/IdArhg8gJ8YxPu3NFTXI1GbkdJVbWQfZbeimhXN+VncgvFnyLt8
 Lm8/FSlZWjgqsPUas43XhDYSnjJNumaKZN5Dziwrmb5S7RGrD/ZaP8xLiVSUhyUJ0/6D
 fUs4DjtKrtjAMlmnpYK8uKOZNZIu467Q39lPlIsWUHvzNedGiB0NOI/y00EnT744WlQD
 MZeQK+pJBNpsWbVG749DdOpHfYPRcA16nbnRKIP4l9raHh8E+VNmTOs1HaOJcoWEXd0R
 mfcgYZm9sFUqp4KCMt+2/p3WOe2ebVZgfMxK5lbndarp3ZIyAb5L0+akQbCOf0Rx4ObM
 2tKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746703043; x=1747307843;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=879OmmlA3sgGXrbvdNOEjTeqe65pLc26GZ0oXu9+SWw=;
 b=eKXgKRD/tZmf2+XE/BAHVMhj6WCpfb57uKqI44Q7i6LvwIwcWRiBTbUmVRmLxonMIQ
 taW0K7L5LYuW3SZTmrPg68vqVw/05tDOxot0Il0sJX5k1t/pwJqRlcCS1IjUot2hm5FS
 Yx6NWsnBNrrRGIUWlgLEwT1O7uKr8Zi9XSZRSZMnfM1yUj/pczEdJZm0aE3rh9CKlBd4
 Ol3YMIvu+e+m/vXDropeR6Hd3KtGiKtOS7fN9HsY74zJkshUHalyOWuqp4LhTcK8SM51
 GMHLk8LJrJv0ZHoP3bmPsC1VtR8cD3IPHmagMJ/+3qPjm5vr2fZQzCMm+OqMBzKokeuf
 KTRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW81Kcsj5SYBAggBDYMBCbXep4WuaDd9tDpfo1leoiXnzEmVlxBNpqAXXGgUJSuX8sCo9UM4WV6YwKE@nongnu.org
X-Gm-Message-State: AOJu0Yx8ljh4bl7koVmt4v6URoOdQODYAzxLdgmVtD3ZU0JYrMGJp1t3
 hbnIL4bkcP95d33SncLfAKnqBx4LdmHCkBOhqBxzhvl9oH9140GuL3thrzbkjl92aZ7+Q6AV/9m
 RUq565w==
X-Gm-Gg: ASbGncsyPsHT+Aj6K7X00QwwdC4CNbMUdCE/im0i0xZAJD4tYETcvD+63wSSNZ0ChEy
 9XMlA1+2PBXTyMCUBJQWbDSmzg0RMafoaXptBfL0I89eXmOoRAu9yAl+6Fy2dKAPkoExBEg0J/d
 C0/ReyZgY7Tc1lMEiYgl7bVRZ1tQFerQvPUI4XL7mmZW/o4eJGfAfGUo85W+n+9X6G4XBF/pied
 P4s//CY2r/xQJGyZHEfT1OPF7+w52IKfwQufNtmw8YeQ5c0diIQIEVNWo2Q5mj4aDaxNWrWhsR3
 buU5kudRFoNtqUFdQWrezcq61c3T8NRgIk17qTKtt+j2aywhTXuszVtkqfruYD6lDGuBKK+5TCP
 GcMGaPNTL
X-Google-Smtp-Source: AGHT+IEEmA37bHyAXwAxCMF/+J9aOyVhHTZspCzYvpb4man9WdfK9KkTZQIg2kTl44Ka3dguZ05DjA==
X-Received: by 2002:a17:902:e744:b0:223:5a6e:b16 with SMTP id
 d9443c01a7336-22e85ed79bdmr48615935ad.5.1746703032324; 
 Thu, 08 May 2025 04:17:12 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e659c92cdsm30379875ad.28.2025.05.08.04.17.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 04:17:11 -0700 (PDT)
Message-ID: <fdafb369-28a0-4dc9-84c2-39e248a5af39@linaro.org>
Date: Thu, 8 May 2025 13:17:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] docs: automated info about machine
 deprecation/removal info
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, devel@lists.libvirt.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao Liu
 <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 John Snow <jsnow@redhat.com>
References: <20250506160024.2380244-1-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250506160024.2380244-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-ot1-x330.google.com
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

On 6/5/25 18:00, Daniel P. Berrangé wrote:

> Daniel P. Berrangé (5):
>    Revert "include/hw: temporarily disable deletion of versioned machine
>      types"
>    include/hw/boards: cope with dev/rc versions in deprecation checks
>    docs/about/deprecated: auto-generate a note for versioned machine
>      types
>    docs/about/removed-features: auto-generate a note for versioned
>      machine types
>    include/hw/boards: add warning about changing deprecation logic

Series (on top on Thomas pc-q35-4.1 removal):
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


