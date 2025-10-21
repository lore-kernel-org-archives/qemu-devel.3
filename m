Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BE8CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 10:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB9vl-0003e0-50; Tue, 21 Oct 2025 06:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vB9vj-0003df-2y
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 06:49:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vB9vg-0000Ge-SL
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 06:49:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761043749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KY+yCMuINXwsw12FS7Y8ZwL2QHEE4bvr8BezQyVIjXg=;
 b=e6uVj7iph0qN4JsX4s+y8/YE6WaxO9GpeyaxJhErR8Wm/t5a1ZIMlm72sm5/XHDpUZShfJ
 owCuXkNYCLcYfMv4NJyMJH0bH+5t4Zb6VHGtHaDhdRzPywDp7TIBXO9bnhmavhY8XXJS7J
 YUlM2aixaCgIFSuYlpjTIMElW5Ejrj8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-Vc1NgvNlOB6neqIoyHpsrQ-1; Tue, 21 Oct 2025 06:49:08 -0400
X-MC-Unique: Vc1NgvNlOB6neqIoyHpsrQ-1
X-Mimecast-MFC-AGG-ID: Vc1NgvNlOB6neqIoyHpsrQ_1761043747
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ee130237e1so2372899f8f.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 03:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761043747; x=1761648547;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KY+yCMuINXwsw12FS7Y8ZwL2QHEE4bvr8BezQyVIjXg=;
 b=l40gap5io2zwsPJHrZRyRWUglBCwOq96fJD9dSUOOSARs2d88JlYrrwTijbweUV+6i
 bnmMBa1f60XbBG70eww6f951rpycXUec1yIV4oqApGEfkeI5V8JK9QRbEjEkdYMuNVij
 D2RPyULPOLi5v31i0J1yd3SZaPleqSFcs17G5/RdquMbBMZ9xlgqMN+C9KGSZQbFKlSj
 XJCnEo4O1iIBQ2tKviMsU04anbCvdvbaiFeyfKeCvVdmYcuqAkk37h8omMW3b31fqdkx
 2b6PvfZn+2vWdX3RQoGviS4MOnO2ISWtd/2hmMScggOCaT1EyB5nHivYkGuQXMVGniv6
 B08g==
X-Gm-Message-State: AOJu0YzoZleQwZlKB3RppGV08bc7IO28tbxIHdx7eThNm800ThhhsL1D
 4CtedRN5Kn4g8u/spU8Q6H3CR3kt1YNotP+UHZI5fY3ymjt1CxAIV5RIR9oV//DAVAI7EnN/vUv
 61UCY8IDh7D9Pp6flD1n5LXpjIYaQqRh1tFUVI9OXy1iujPrBlw19lHwu
X-Gm-Gg: ASbGncvoh/VPsz7HrJ90jWQrmIo8rAMygihIgNxE/T5ypFrIsnSXeutJtfg4ns3RL3i
 K8UxLr7bwjmFwYGub8asnqxelPVOo0gF5tvsmbKMtX+oOrLwEQJUMau1ZfpRu3UF/uMCYhuxloc
 cq7LxS9UldblqYmDDcel/PHAPzHNUeHog8hHi8yooPgEM3ivFKK7uP8eFzRBOJz2QoEF8kVi2IZ
 DFa24jgqU4+SHLZ33PoZUwS4nyGuo8VxZ/3hFYflEE1HI61oGncIyR8Hu6F/+kGc7FbopBvJQsS
 mCKcq0P/AG0KpiMJq75t4+ZK77KNRsg9pDd1CO+dTT95VU7gSbpuhmRZSRxRpZg2M9NNmbriiGl
 BiAady2R7qgkmQqAOPa2h4pSyXySJXkW27JHw1xLLjEWdosCsyJPSi14p9jSFjdee0aP6UVEXW+
 3vNw==
X-Received: by 2002:a5d:5d82:0:b0:428:3fcb:197f with SMTP id
 ffacd0b85a97d-4283fcb1b44mr7192617f8f.63.1761043746918; 
 Tue, 21 Oct 2025 03:49:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4ePyzsLTQU3d4iCNe2rkkZG1XGmMd5C3QmQYhTNZXg5vS4Gj5yRSLbjeIByBXZSzhASXOCQ==
X-Received: by 2002:a5d:5d82:0:b0:428:3fcb:197f with SMTP id
 ffacd0b85a97d-4283fcb1b44mr7192582f8f.63.1761043746496; 
 Tue, 21 Oct 2025 03:49:06 -0700 (PDT)
Received: from [192.168.10.27] ([151.61.22.175])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-427f00ba070sm19960195f8f.42.2025.10.21.03.49.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 03:49:05 -0700 (PDT)
Message-ID: <32170b83-473c-4eb8-96dc-9180c51fe872@redhat.com>
Date: Tue, 21 Oct 2025 12:48:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 34/43] audio: rename AudioState -> AudioBE
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
 <20251021090317.425409-35-marcandre.lureau@redhat.com>
 <1bd34160-d034-465b-a1ac-0e734ed40484@redhat.com>
 <d26b8838-c4a9-443f-a651-f46901a40865@redhat.com>
 <CAJ+F1CLoaufD_1tFUd_1uckWZLXVQ7E-GpRDZRDXtfi6unBw7A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAJ+F1CLoaufD_1tFUd_1uckWZLXVQ7E-GpRDZRDXtfi6unBw7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/21/25 12:40, Marc-André Lureau wrote:
>>> BE and FE aren't used in existing code though.  Looking at current use:
> 
> There is a top-level backends/ though. I meant to say that it's
> usually clearer for everyone when we talk about "backend" vs
> "frontend" (or not?), and I wish we would follow that naming more in
> the code.

Yes, but the front-end should have a *pointer* to a backend.

>>> - BlockDriverState*/BlockBackend*
> 
> I am not very familiar with the block subsystem, but it is seems
> BlockBackend is actually the backend and BlockDriverState is
> implementation data detail. Correct me if I'm wrong

Yes, note the "*".  What I meant above is "the frontend has a 
BlockBackend*, which itself has the internal BlockDriverState*".  Same 
for character and NICs below.

>>> - Chardev*/CharBackend
>>>
> 
> Those are actually always confusing... and I remember I attempted to
> rename it in the past... CharBackend is the front-end side..

Yes, they are confusing.  I'm not sure why it failed, but 
s/CharBackend/CharFrontend/ does get my vote.

>> QEMUSoundCard's name field is basically unused, and QEMUSoundCard should
>> be just an Audiodev*.  There's no need for a separate AudioFE struct.
> 
> For audio, it's pretty obvious that we have "backend" object to
> implement the host audio subsystem details, while "QEMUSoundCard" is
> the "frontend", or "client/user" context.

I agree, but unlike character devices, QEMUSoundCard is not needed at 
all.  So you can drop it and only leave Audiodev*, or AudioBackend* (but 
I prefer Audiodev* which matches both the option name and Chardev*).

Paolo


