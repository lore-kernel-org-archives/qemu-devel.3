Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F15C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 08:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5LZm-0005rz-VB; Fri, 10 May 2024 04:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s5LZi-0005rK-J8
 for qemu-devel@nongnu.org; Fri, 10 May 2024 04:25:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s5LZd-0003KJ-8Y
 for qemu-devel@nongnu.org; Fri, 10 May 2024 04:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715329547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ev9lZW95NIwy02t2zqXw0EBk/79+d8Qjz1pomOWn59o=;
 b=atl5rsMCxkNXJxvgbCekjpqnNCLtnQhWUm2bL9osVq0zyZnALAGgUuQ4DGWzndVdHCgsy9
 qz6CWZtFdzBWPYhmH29ZpPkCl2g2pPutvgMM4MIl9aXkqbHiY8d3bQWG2zeQP/1/iKqCER
 cJL5T4577xLGVp1iBRUYAurYwBi4kXQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-Bn5KIybQPYquo2KvYZGgTg-1; Fri, 10 May 2024 04:25:14 -0400
X-MC-Unique: Bn5KIybQPYquo2KvYZGgTg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-43d7cfc45abso21317591cf.0
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 01:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715329513; x=1715934313;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ev9lZW95NIwy02t2zqXw0EBk/79+d8Qjz1pomOWn59o=;
 b=ug5p3sdQHS7wqUd6SY6uQsBI5iLd3C5RFJ4u7Z42OQzQXk6VhznTnc5CLXGceZ52+2
 f9NabVR3Hp2A7fhMD62mZxMs9PZx81bSORnTYwuRCIegOTSEaTEpE3hf81ipEGG4bHgx
 sYFIXYFOs/5aRse3Na+U43+Ln9LGBzBgpgjwd+eYfc8HzQ/ob+i7ily/qrDTCcvdtZoX
 26Z2iH6QnL84fEgD5T4lLv/vU4KArSuALG7uTIaZSgqQQc/P0IjERa27ij/19fdNF4f7
 6WcwZ8TVTZ1bjxiNbgkt/a4B9HWdC8QfyQ3SgyGhro+pyZglNr3gTeu+T/5nQ34WRigw
 PxQw==
X-Gm-Message-State: AOJu0YyR962NWmT+V55h3IvjZRIWxmSYZvNmk9XRn37V2cVT+AFMf4du
 mVdwiHltowOC4S9yWHk1umH/UtDFTrW961O+gBPfdCBOfxHjuKW8I3NIpCzbVQjdbnPGruwPwof
 3SJS12x6exeDNVUNYnFGp4sEKunyrf1Jc28LBhZqW7NavVtGsUt3B
X-Received: by 2002:ac8:7f51:0:b0:43a:a8ad:1135 with SMTP id
 d75a77b69052e-43dfd9e5cf7mr21004321cf.0.1715329513574; 
 Fri, 10 May 2024 01:25:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXNx3bJGFmqu3MuJO/VTaL5OBV3yB61dXcEhdRTWeYD0xC4ci7Eo9dazy0U6mRYf2yJZbS/g==
X-Received: by 2002:ac8:7f51:0:b0:43a:a8ad:1135 with SMTP id
 d75a77b69052e-43dfd9e5cf7mr21004001cf.0.1715329513227; 
 Fri, 10 May 2024 01:25:13 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-56.business.telecomitalia.it.
 [87.12.25.56]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43df56bfcf5sm18615841cf.79.2024.05.10.01.25.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 May 2024 01:25:12 -0700 (PDT)
Date: Fri, 10 May 2024 10:25:07 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, 
 Coiby Xu <Coiby.Xu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, slp@redhat.com, 
 Brad Smith <brad@comstyle.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 gmaglione@redhat.com, 
 Laurent Vivier <lvivier@redhat.com>, stefanha@redhat.com,
 David Hildenbrand <david@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v4 03/12] libvhost-user: mask F_INFLIGHT_SHMFD if memfd
 is not supported
Message-ID: <kpn3nf5lcgswpejf63ufcc4moynwdlxtf2a3saapbtd2laicf6@tk7oytq5ue2q>
References: <20240508074457.12367-1-sgarzare@redhat.com>
 <20240508074457.12367-4-sgarzare@redhat.com>
 <bde68851-04a0-424f-9412-69d11b9a9caf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bde68851-04a0-424f-9412-69d11b9a9caf@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, May 08, 2024 at 12:39:33PM GMT, Philippe Mathieu-Daudé wrote:
>On 8/5/24 09:44, Stefano Garzarella wrote:
>>libvhost-user will panic when receiving VHOST_USER_GET_INFLIGHT_FD
>>message if MFD_ALLOW_SEALING is not defined, since it's not able
>>to create a memfd.
>>
>>VHOST_USER_GET_INFLIGHT_FD is used only if
>>VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD is negotiated. So, let's mask
>>that feature if the backend is not able to properly handle these
>>messages.
>>
>>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>---
>>  subprojects/libvhost-user/libvhost-user.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>>diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
>>index a11afd1960..1c361ffd51 100644
>>--- a/subprojects/libvhost-user/libvhost-user.c
>>+++ b/subprojects/libvhost-user/libvhost-user.c
>>@@ -1674,6 +1674,16 @@ vu_get_protocol_features_exec(VuDev *dev, VhostUserMsg *vmsg)
>>          features |= dev->iface->get_protocol_features(dev);
>>      }
>
>Maybe move the #ifndef here?

Yep, I'll do.

>
>>+    /*
>>+     * If MFD_ALLOW_SEALING is not defined, we are not able to handle
>>+     * VHOST_USER_GET_INFLIGHT_FD messages, since we can't create a memfd.
>>+     * Those messages are used only if VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD
>>+     * is negotiated. A device implementation can enable it, so let's mask
>>+     * it to avoid a runtime panic.
>>+     */
>>+#ifndef MFD_ALLOW_SEALING
>>+    features &= ~(1ULL << VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD);
>>+#endif
>>      vmsg_set_reply_u64(vmsg, features);
>>      return true;
>>  }
>
>Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>

Thanks,
Stefano


