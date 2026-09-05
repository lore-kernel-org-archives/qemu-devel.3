Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759F0C624DB
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 05:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2imA-0006Fi-IA; Sat, 05 Sep 2026 01:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x2im8-0006FV-0k
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 01:17:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x2im6-00052p-KG
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 01:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788585427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NYNfR20/FO3Fhd77hXXx1jeRfJFM5ldPgCh815IwWoM=;
 b=gEVJLBpDWI6LHLD9BNVS1yX3vahBygjmF7yFWJU1zkT4Os7hy6QtDoCj1OwqF0mSe82u6h
 MrHac3bbRz8Z3DpK4L8uxIr5cq5isZwbORpUfBaDrE747D86+tKGulI29BPLa233vb+pHE
 iSDbMmjljPXdXb06HpOgGULP1pCPKSE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-iHKBktxJNJmvuJe_Vm26ew-1; Sat, 05 Sep 2026 01:17:05 -0400
X-MC-Unique: iHKBktxJNJmvuJe_Vm26ew-1
X-Mimecast-MFC-AGG-ID: iHKBktxJNJmvuJe_Vm26ew_1788585424
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49554715277so16335985e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 22:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788585424; x=1789190224; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NYNfR20/FO3Fhd77hXXx1jeRfJFM5ldPgCh815IwWoM=;
 b=GbvnzCA/hJ/1wx7kOcjOQ3Skchz2UdIJNmzpT0VOaq/1YVrjD85VvV36zJm87pflk0
 BbdwuYx2DweS/HO8gY6N5FfLs/fos/mv2zZ3KqZNrrbA0Bl9mVRM1nsiIn6Z5KgkS/3S
 hbv8hCm8E6Q6kRgVPJKHMRMK1kuCnzpfQsG8InWi89axu8FqE7Yst2sSqbBiI0FgKfDF
 4rKeoUBjf9afoV5sVfVKMvsMcmCY0mG44mlYBCDEYTw5M+AasrGNmwc27q4zYsVrx2Ek
 /fJ5GFZGcmAMSNPalWnmqks650vXF6oOwIAqxLU1si9ivqf3ZzUx3MyJOmDyOdkUZ6y7
 UpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788585424; x=1789190224;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NYNfR20/FO3Fhd77hXXx1jeRfJFM5ldPgCh815IwWoM=;
 b=JNDyI4JhlNbjKadIwcVClf+yRzSMp8KLdY+LyoBrOVtsvO5VBRy3V3bIYh0Hzt2i3o
 GaPcy2x+vrp/D8yyS+mVQpLMIybaTlUBMWtULAZqNTj/ziPYpXClp6xzUTQKJ6N7Q850
 zAK8n+jfXxHJaJPtmDltoWgNQLzvtseRJU3JI/FGMBzsUMnqSGDWUQkyrMYl2u/jNd1J
 FiVsCvPjJ+M2/f9XNxK+rieb6ElaXwUkngZOJUjALvlN8Nm+7g/I0wKPHQAQlwJisxx6
 r0EfnB5XWUseIW9gOau+Gi7GwwQsD+RJqviNatdQ7KgUU3utgEDQ8JvycnzdsLNu/1Za
 3KjA==
X-Gm-Message-State: AFuF++kqXnHfX1nheZ1hWEOl4HviRM/rQbrwq7mhCKkfUT9Zw82cP0Ng
 YmAT5Q9WgPKYVxM02zJuXvj7QJWJhKd3uZxZXC7rpgbd7kwUzbbMp0aGHWYLmqxG7cXV66brD3Q
 /CgUmnuKElEH+X8LWgacp8mW/JpvERt0dDytwthyn+T+knWmkcCO5sagT
X-Gm-Gg: AYBFou2Kro95h/5lpDa+E2EJiRQgwF+yoWx/V+vIAO1SYo8/hSm035adP8Z4MWfVQU7
 T243VbjSqRAx5Cw2op2qlgVmxlz1zkDFBYsbXzAD8B8vaipnygvU1emqhY2WNiuwG28QLI1l+wi
 7lH2A45Q20L5lYsHyjkhZTaD6SvvdkIa8WiuxFTJ4XVv2vr74jI+/lsAI29Wv8Q6iD9FZ8rTR2u
 d9A1GnzoIm9IutdbfKXxYhPE5liY6+z1mQMHQRvGD9mW5nOQXIpZF2r8Nai8uaafToQdom/gyND
 UpKBjQMzCx6PDjvX4VHNFbGoNv5sTcZmqpXKK7fg+lrmjWO54KNAk3D9SBPmc4tBEI5mHyEgEz7
 MJsTgFUEKG+pwvwH6RkI0kBVEfMdxweBrkmH+OSJzOiAPJbKXQV41VQo4vo6O9jOLABQ3MagzDj
 3xGvRI0rVlkE9S+gFAqS/3/fk9TjVa
X-Received: by 2002:a05:600c:8b6d:b0:499:a277:e8b5 with SMTP id
 5b1f17b1804b1-49cf7fdd67emr183062095e9.3.1788585424201; 
 Fri, 04 Sep 2026 22:17:04 -0700 (PDT)
X-Received: by 2002:a05:600c:8b6d:b0:499:a277:e8b5 with SMTP id
 5b1f17b1804b1-49cf7fdd67emr183061735e9.3.1788585423837; 
 Fri, 04 Sep 2026 22:17:03 -0700 (PDT)
Received: from ?IPV6:2a01:cb06:c059:ed21:e577:db2a:8fd7:fd5f?
 (2a01cb06c059ed21e577db2a8fd7fd5f.ipv6.abo.wanadoo.fr.
 [2a01:cb06:c059:ed21:e577:db2a:8fd7:fd5f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce591f846sm113232415e9.1.2026.09.04.22.16.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2026 22:17:02 -0700 (PDT)
Message-ID: <887c7721-6c2b-45a6-8c12-d9f978f03551@redhat.com>
Date: Sat, 5 Sep 2026 07:16:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] vfio-user: support multiple FDs backing region
 mmaps
To: Naman Gulati <namangulati@google.com>
Cc: qemu-devel@nongnu.org, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Alex Williamson <alex@shazbot.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>
References: <20260826050039.2068138-1-namangulati@google.com>
 <CAMP57yUuJUrpPtvf6Nf5SoDZ7Z+dfXFmHB-0AJ+vhzysjvgxYQ@mail.gmail.com>
 <135d159a-2117-4595-ac6c-4d0ff4c843a9@redhat.com>
 <CAMP57yXGDz+AM0C54MZKgYDCunWgZA2drCMaZddA5CGNsueDqA@mail.gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <CAMP57yXGDz+AM0C54MZKgYDCunWgZA2drCMaZddA5CGNsueDqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/4/26 18:35, Naman Gulati wrote:
> On Fri, Sep 4, 2026 at 5:38 AM Cédric Le Goater <clg@redhat.com> wrote:
>>
>> Hi Naman,
>>
>> Thanks for the series. However, the multiple FDs are a vfio-user
>> transport detail. The core VFIO only needs to know "which fd to
>> mmap for this subregion" and it doesn't need to manage arrays of
>> FDs per region. So, I'd prefer :
> 
> Thanks for the review Cedric. That makes sense to me, I'll refactor accordingly.

To help reviewers, please add to your .gitconfig :

   [diff]
       orderFile = /path/to/qemu/scripts/git.orderfile

Thanks,

C.


