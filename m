Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651D7C44508
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjDxg-00083M-1W; Mon, 13 Jul 2026 06:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wjDxb-00080g-46
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 06:32:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wjDxZ-00016C-Lr
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 06:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783938744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=u96zREFqVVRn1UxC/Vx7RwZuddfsts/PtT0uqtC2woQ=;
 b=eagQSo/cqDJ3N/5sN2U74oHzbE0mRi6OWV2PfIjNB0VILqC4vtcR9f2XYvGvgX075Yu2/L
 iSd4ujqUBuC/mQeUyba8RFg2XBi3P5agHgjRdk5YVkPxTR/muDWik1nsimQRF+AgmMQ/hI
 RSlVOwD2fglw0LuJTmJblLMX7Q5fM6w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-cFSFWegCNuadD4FVZm0EJg-1; Mon, 13 Jul 2026 06:32:21 -0400
X-MC-Unique: cFSFWegCNuadD4FVZm0EJg-1
X-Mimecast-MFC-AGG-ID: cFSFWegCNuadD4FVZm0EJg_1783938740
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-493c20d0468so49818435e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 03:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783938740; x=1784543540; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=u96zREFqVVRn1UxC/Vx7RwZuddfsts/PtT0uqtC2woQ=;
 b=aP4dmOfthhVKTdpGpdAdLI8yWcBRvShHPMqlRa8IiSU6ac7fGyx3t655+4CI1jH+oG
 e4FzTEPGu1SdiOL3Kq2xZ1pdNLSZd6mhk17bG7OPtNMtR0HTkSRvDL0BuPdUxpJuLGZF
 PnC0b8N119POZUjDFXK2EeA5cUjiMyRgEYzg5CrYZCUvL7ph4xuGpxjjHYwlIXWdHOSs
 Rz0i0Bs3YZn8yMoqe3YPbm55Vcqla9ZpZz5czxEoXcWc2gRq4VnYY9PDHZ/9PyaNgEBE
 2DTuwBrrLRqcK2CbDD05KxV7Jvt9yQ7WvEj2WoquaMrt0eWTnDZHncwBhUg1RakWTF0Q
 TNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783938740; x=1784543540;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u96zREFqVVRn1UxC/Vx7RwZuddfsts/PtT0uqtC2woQ=;
 b=Cjuqyg91RjiXxaqeTLHnRjtcnpj/6w5O6V/mArkL7s/fAlzPFcCY3KJZH3jFw1Boah
 4H2yUIAyXXQDqxaru3O45CALEFA9eY+t1wS8VfRZAhG+fFec6VXmq4FVS6oqWeum5vrD
 tukvsCLM2e7PBq0+4wv38KMg2I6XeeXwTWhKLJyjYa0tDXSAGyKKAfupxd65LrWCS+i6
 b1d/+U5wOrjLDk8La4dBfUTQmQPt0pCF4EjuQcEnZ8cW9q1OOpgolmmJPyK+rKbFtwJG
 Ty1cQUZwoTZ/SVXM+273s/0fcY6ozcx5KXSojVzxg0xEH5pFn63QAiu0SsjCFjQ+Ap97
 DfuA==
X-Gm-Message-State: AOJu0Yx0EZ4UI8uyHVRjhy1bX4wMdno3tTrNahQGdCrnFIJ1avMrGlNA
 /NYUyPYArJJhZsP4vUlcwdg89J6yGkdwaT3K7zlfe42oBWrWaoZUiKbSoi6uoDh7AGt6kdr77Mp
 k0oEc4Zplc3D6j1BJdqfwEYOWY5vjktPUCgaSYiGmXWP3vreb7+snfm+P
X-Gm-Gg: AfdE7cmsQKcEMnhlA5U3YUvkX4uFtgq4vPf/Y7PU6MJvk/6fwIDRbfGD8BdM6bHt8vw
 N1s1qpOdJsCOiJ6Fov3wQSFgfJN06/g46ZvpY8qzrVv58EdGXPlpHR7ntb0oGckyNDYr2kuuzY0
 jziDRFIF7+pNgGHZjLtiIeWpz6rtZT+DrvrgK9ddECnS0gimqU3bU+M88zfBDDfSckadKndoqW8
 abTMUrIh1KQTLtn0NN2GXW9fb4KnWlpR7RNl67BjEH8P/VHDCX3XTMZqLYxXDk1iemDAOWWxYSA
 tXGkUE6exNYjjgGUaFyhTAEjCk4TzSjTDsyDS+/8xYRdufODAvtWtNlHp+vDJnQ8RkPRIHkgFVJ
 zJr8O5leK
X-Received: by 2002:a05:600c:4e0b:b0:493:bc4a:c6b4 with SMTP id
 5b1f17b1804b1-493f8851d13mr82233715e9.38.1783938740301; 
 Mon, 13 Jul 2026 03:32:20 -0700 (PDT)
X-Received: by 2002:a05:600c:4e0b:b0:493:bc4a:c6b4 with SMTP id
 5b1f17b1804b1-493f8851d13mr82233405e9.38.1783938739856; 
 Mon, 13 Jul 2026 03:32:19 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.244])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb74835esm379865215e9.14.2026.07.13.03.32.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 03:32:19 -0700 (PDT)
Message-ID: <f91767d6-c78e-4a2e-b67e-fc74e07a0930@redhat.com>
Date: Mon, 13 Jul 2026 12:32:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] hw/usb/hcd-xhci: Remove the FIXME macro
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260713100508.123623-1-thuth@redhat.com>
 <20260713100508.123623-3-thuth@redhat.com>
 <CAFEAcA-n-9YVVRr2G3wP0a7sp6arZS4Vmqt35TJY40iGM=DCSQ@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA-n-9YVVRr2G3wP0a7sp6arZS4Vmqt35TJY40iGM=DCSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=thuth@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On 13/07/2026 12.16, Peter Maydell wrote:
> On Mon, 13 Jul 2026 at 11:05, Thomas Huth <thuth@redhat.com> wrote:
>>
>> From: Thomas Huth <thuth@redhat.com>
>>
>> The FIXME macro is only used in one case, which should hopefully
>> never trigger: The containing function handles all the USB_RET_*
>> values except for USB_RET_ADD_TO_QUEUE and USB_RET_REMOVE_FROM_QUEUE,
>> which are both internal return values for when an async packet needs
>> to be queued or dequeued, and which shouldn't still be the status by
>> the time we get to this function. Thus let's simplify this spot
>> and use a g_assert_not_reached() instead.
>>
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   hw/usb/hcd-xhci.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> Not sure if some compilers/analyzers would complain about the
> DPRINTF followed by g_assert_not_reached().
I hope they don't complain since the macro is disabled by default...? Or 
shall we play save and remove the DPRINTF here, too?

  Thomas


