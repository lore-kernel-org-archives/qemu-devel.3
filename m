Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3601C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 14:49:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0iLI-0005Oo-GR; Fri, 04 Apr 2025 10:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u0iLG-0005Nx-9j
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 10:48:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u0iLB-0004Hw-J0
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 10:48:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743778095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CVbKRUuCL8eAEJaA4xbFVZSVmtUMD88E6EdyJZh4aZ0=;
 b=h8U/LCqD3wbJSBzm6flZyzdyjXSAcycc6FZxs0Qz0tt4ehHOKeVUI0IOOnkQIr7Lg1uy+F
 bX960tj2tshcQiSbea10a+h3LcsZrtCSrXl07OeXB3/staNulOk9Xotrixd0kUUfVjyIlf
 Mne8R+f46qVYR/b19pRCyPrVGD6GNcg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-vwmsKAs9PY2gwg_J-waE5w-1; Fri, 04 Apr 2025 10:48:13 -0400
X-MC-Unique: vwmsKAs9PY2gwg_J-waE5w-1
X-Mimecast-MFC-AGG-ID: vwmsKAs9PY2gwg_J-waE5w_1743778093
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d0830c3f7so17733465e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 07:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743778093; x=1744382893;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CVbKRUuCL8eAEJaA4xbFVZSVmtUMD88E6EdyJZh4aZ0=;
 b=EXWfO/LKqxACcN5eE37bDAFHLq3iQp1xoaLndXrHrY+6+k6r6SZEMPgwZ7Ut6suHYF
 hAtPmgSmqK2W+lVwEOvihkLOtbseo1d8tSw+BIteiM39z9cgjk2nJyxpvj+tiJZw/DVa
 Inlvmtn+wPD4MZw5fZkbyQy0C7vGQu5BOoR4PHFaKEbNhjXOb2FxYEd72+saWvSA4/If
 dKu5qSkG5srkuIblpoqT8HLgv87rrDEYfuTboBF/3n+Rb3xlg4glnIxwZlblzoeSaNmy
 sSHrvYpdq7fr4IfoJMrugkjF42d/M3DPEXT9uaJgQj0E1/hyAsT5Sosv4chaPZmdYswh
 4Vxg==
X-Gm-Message-State: AOJu0Yw9iMWThrvtbZNQ15VbcMwCkX8bv9FgWHisj2fFYLoOwxof6pqW
 nrFp8CFL5+kElWs6PznKotc3FbH0PmAmN5jpYYYvQw7dNwuUVIih0/h1Qh1C+1MVrz2MiLtRlYx
 Un4n62r8pINdHRNacBW0ne7C5CXVUciBqURYxgwWnst134cvnMVY3
X-Gm-Gg: ASbGncu1MsqP6gWcoF5iRfYbMEjqkxUkI6H76FTt7yJyNVO1DTE9k0fTwkbxLpRp2B6
 zNpmWBzdpAvt0IiFU5/bki1D6vk9cp76p2iqJMA4zdFAPNOC0qwcqXNK64OFo4IBZqXqF9Uj/J9
 PE5xF2+zXO+LRcGMUBiD01LZzUm92oTMdYQgz5YTexoB+uVSgpcirbUnwPwg2okFZne7ysbbKaA
 w3zNaOV+dHxI1BnmujW0JEmstG2D13uNKyATVMnJikYv4YqiBeKPAl5xayXP6GekM0Ax9n89fSP
 zEM/zhT06Nuu+dLRPV8Zv0PSWVkE9GcV76aXzkIPTno5CDk/lZ+lSQ==
X-Received: by 2002:a05:600c:384e:b0:43d:b32:40aa with SMTP id
 5b1f17b1804b1-43ed0b83705mr35085505e9.3.1743778092786; 
 Fri, 04 Apr 2025 07:48:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGVuiWRNaVkvgbvVOOM9uwB7fVJT+1jqUqzTILzscy4h9S1tXspG37Iz9xKt7/DX1Gyih8YQ==
X-Received: by 2002:a05:600c:384e:b0:43d:b32:40aa with SMTP id
 5b1f17b1804b1-43ed0b83705mr35085235e9.3.1743778092474; 
 Fri, 04 Apr 2025 07:48:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec169abd7sm51079845e9.18.2025.04.04.07.48.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 07:48:11 -0700 (PDT)
Message-ID: <dc29a4ed-ed8e-4d49-8da7-64c2fc1bb4c8@redhat.com>
Date: Fri, 4 Apr 2025 16:48:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/28] vfio: split out VFIOKernelPCIDevice
To: John Levon <levon@movementarian.org>
Cc: qemu-devel@nongnu.org, Jason Herne <jjherne@linux.ibm.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Halil Pasic <pasic@linux.ibm.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
References: <20250219144858.266455-1-john.levon@nutanix.com>
 <20250219144858.266455-10-john.levon@nutanix.com>
 <52ecc629-4138-4436-bc38-b5f427dd3d7f@redhat.com>
 <Z+7Oif+ZTFRYBqXa@movementarian.org>
 <137a1646-0bb2-4d79-bb6d-272167140bd3@redhat.com>
 <Z+/q85szQ61Zf46U@movementarian.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <Z+/q85szQ61Zf46U@movementarian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 4/4/25 16:21, John Levon wrote:
> On Fri, Apr 04, 2025 at 02:49:40PM +0200, Cédric Le Goater wrote:
> 
>>> If it's possible to set up vfio_user_pci_dev_info and its callbacks without
>>> needing a sub-type then maybe not?
>>
>> I think the vfio-user-device could inherit directly from vfio-pci
>> and override the io ops callbacks. It would minimize the changes.
> 
> We'd get all the kernel-vfio specific properties then though?

OK. That's what I thought. It was not clear in the diff.

Let's give it a try in the next spin but please remove the
VFIOKernelPCIDevice type. it is not needed.

Thanks,

C.


