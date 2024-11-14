Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7244D637D3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 12:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBZ8N-00087F-3x; Thu, 14 Nov 2024 07:39:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tBZ8I-00085t-Q0
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 07:39:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tBZ8G-0002OT-8b
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 07:39:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731587969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YPSVrJzpRJzvudiys1gNZi22Tlpw5mgbKPwPrZqSdFo=;
 b=PL0rLdwyDWnJ3sq88Hl1Wk5vrNtPn86tXA8RIYXqayxjmRa3GUqpxtMlW/c33PPsvbq8oZ
 CCT1WQfpxR7UgUlH1HBeY+Usq1xuWDryf3NVLQLOJdjlcLe+iHK5ubqj7z7gdwWyvcU3sM
 jPH54sjCRRcfB+mEpJWHhe31ghgn0cQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-CeFY-JMTOVu1JxnQHOnnLw-1; Thu, 14 Nov 2024 07:39:27 -0500
X-MC-Unique: CeFY-JMTOVu1JxnQHOnnLw-1
X-Mimecast-MFC-AGG-ID: CeFY-JMTOVu1JxnQHOnnLw
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d59ad50f3so311275f8f.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 04:39:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731587966; x=1732192766;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YPSVrJzpRJzvudiys1gNZi22Tlpw5mgbKPwPrZqSdFo=;
 b=e9IPcGl4JqWUpHedK0L3UFLBl4VptHrYDRU+K2kmbcAigLQqGZF5sDA80ms8i5BgS3
 AbhpW7bzEwA0JNhTgF2v4AQsdLUC4xPP44RFen7fumtFYSWxZMPefkXoWPEMWiDlQrj/
 PeFGH4lFxY0k0eys1PT298gydTYTZNqMUEQodr9At4hMf5JC+jXHDFvArUDiXXKIvBk4
 724pCVQwcyT+TtU8Xbxxv8IvM/urBxKtTQita3PTlwpYYo6MdEYgPTw1gykcgHjlx/8f
 lpnToJ7Gs2oU5dlR7sUcgFL2JP9+2+FJsQcAe2JzO1HAfm233bkuGpFcjGW8o30qJt3e
 VGtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq0vnR5St9Wu+AtdZrcNk3uJTKcC/HrsGHp/5leyliWjUH9r9m3WUS0JgjhTFTwDpEZHhD9OY+fKWL@nongnu.org
X-Gm-Message-State: AOJu0Yz5c+38nKjgqwTnIfajcWzA/q1ciDvLAjpg/UbKZIy4qu8NTtnG
 jeofAgmSb7S/i25f0mTKWXDI6K8W0tQVSx8fNZ9iH8tUlVL8ykqxKBnzBr6+ejbQXAkzY28NLC7
 qYxXDXz6uHHBKBFbIDptqgRVdpD7PD242pfHbTm8SQ758nNpfTuEK
X-Received: by 2002:a5d:598c:0:b0:37d:462a:9bc6 with SMTP id
 ffacd0b85a97d-381f1883d7bmr21385524f8f.36.1731587965845; 
 Thu, 14 Nov 2024 04:39:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFdRkck6TSRsEgZs4sQt/34l9fLnJd9CRDo05s2+ssq5H9Td7PT2YsUNqB3LTiWiPLf9tGWw==
X-Received: by 2002:a5d:598c:0:b0:37d:462a:9bc6 with SMTP id
 ffacd0b85a97d-381f1883d7bmr21385506f8f.36.1731587965417; 
 Thu, 14 Nov 2024 04:39:25 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-49-115.web.vodafone.de.
 [109.42.49.115]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821adbbbb2sm1377537f8f.54.2024.11.14.04.39.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 04:39:24 -0800 (PST)
Message-ID: <a3d5ecee-3959-4136-a29c-1f7ec36831e3@redhat.com>
Date: Thu, 14 Nov 2024 13:39:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/s390x: Restrict "loadparm" property to devices that
 can be used for booting
To: Jared Rossi <jrossi@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>
References: <20241113114741.681096-1-thuth@redhat.com>
 <bc1e420a-65c1-4e11-901e-24e55dc2265f@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <bc1e420a-65c1-4e11-901e-24e55dc2265f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 13/11/2024 15.49, Jared Rossi wrote:
...
> Hi Thomas,
> 
> Thanks for putting this fix together.  As we previously discussed, I do agree
> that my naive implementation of the “loadparm” property at the top-level
> CcwDevice was not satisfactory, and certainly virtio-gpu and virtio-tablet
> should not have a “loadparm.”
> 
> The reason I had not yet submitted a fix is that I’ve gotten some feedback from
> the Libvirt side that suggests the CcwDevice implementation is not sufficient
> in general.  Libvirt will require that non-ccw devices (e.g. scsi-hd) also
> support per-device loadparm.  I do not yet know how to add that type of support
> and given that we are in hard freeze I’m not sure it is possible now.
> 
> Obviously this is not ideal, and I truly do apologize for the confusion.

  Hi Jared,

yes, that scsi-hd problem is a little bit tricky, since it's common code 
that we should not "pollute" too much with s390x specific stuff, especially 
since we're in hard freeze now.

After staring at the code for quite a while, I think one option might be to 
just add a string "loadparm" property to the SCSI devices, that's just a 
simple two-line change to the common code. Patch suggestion can be found here:

  https://lore.kernel.org/qemu-devel/20241114122919.973930-1-thuth@redhat.com/

The only disadvantage is that this is now checking for valid characters in 
the string after the property has already been set, so it cannot prevent the 
setting of bad characters. But it still prints out an error message later, 
so I hope that is also still acceptable.

Let me know what you think about it!

  Thanks,
   Thomas


