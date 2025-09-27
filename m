Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B45CAC5B8
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Sep 2025 16:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2XUe-00034o-Ui; Sat, 27 Sep 2025 12:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v2XUb-00034a-Hs
 for qemu-devel@nongnu.org; Sat, 27 Sep 2025 12:09:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v2XUR-0005p9-HQ
 for qemu-devel@nongnu.org; Sat, 27 Sep 2025 12:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758989373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6X2pIhQhMuIBfOkrtxV66FunkRTFnQu1GYUe3+oiBDA=;
 b=afGYX3MFjYcGxqSBJqyBYsgjboszN2PYJ5txLr1TpkdNr9zDOb5RB0PBhyIVEP/jgVmS4Q
 eYVlVXmAXcnQkIx3W2EkdnYct89fMH+OpLHg1/9TasKHTRIe06vf5L38qhkpOy019Xzdqr
 MvU3KqzEpK0o4ODOiUrDhKzRsMyM7HQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-VhCrsn4LPpinTw2W-zIwmg-1; Sat, 27 Sep 2025 12:09:31 -0400
X-MC-Unique: VhCrsn4LPpinTw2W-zIwmg-1
X-Mimecast-MFC-AGG-ID: VhCrsn4LPpinTw2W-zIwmg_1758989370
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ee130237e1so1403113f8f.0
 for <qemu-devel@nongnu.org>; Sat, 27 Sep 2025 09:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758989370; x=1759594170;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6X2pIhQhMuIBfOkrtxV66FunkRTFnQu1GYUe3+oiBDA=;
 b=lHrK542/R7Yw/Yk2HJ5WdTkB8N9C5L0ed2wGU0M1ACNSSSDWQfx5tiUuR0Cq/Z66+F
 oHL+P8tX39lMM4ry91sdkE6+yVof7GrTp191DyyzqBAUrGcqVS+uQVQUaHa2gfmzD41O
 5yk3Fow+HUyk4Pm7J+xldfjMXgwBf4RObXBLoUxvg7sFNonRshjxnbxLN2Ob+75ze52s
 CCSEZ78OppHFvSeld/QdPz2DNVb4gsVX0CFIFc9k+020ga5w+gby6UUL94XzkFGsfCeV
 J0BDM0aP0XFyrxN6ClL4W+PmhrlG3BoI/Rh7BDm+7G8WhDDL8q9M5bvoP0KRetf2xIfw
 qSGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXajbnADxxPiXdjYIIMTLcmHHB5Ccqu1+k+6AbBuyI7FVrGTTAox4Pu1ZSh0GJ7e041CiYsdJ5EjNhM@nongnu.org
X-Gm-Message-State: AOJu0YxDOd7sxhaZm/Eqr9YZ0CHkJubTGMAQa2f2Wlh0IK9IRGTZbxRO
 WblEKJogfriiOcZV4XQG6wGofJAOaD6RHzQTBVZ5jlBzWkpymyiznCQ9fmFDZJfwdQC0yBdTK5N
 1dAF03NiE/1OFMaSRKY+uERwGgTdV+rc4Je5+JdWFDufos5Mhd/y8yGcg
X-Gm-Gg: ASbGnctXUgHgYvxuWiDxses45KLvI8TLzuKmMMsbwybt1GVK1oGS59iDGU0CrsYk1ve
 g/2FK1hwA/RegKw9SPeudJWSIaXNwjLrszMXUDfViYz9xfqkcfyHJsJH4OfQEiNo1ZLRrmxhjCf
 NsXpZC84q0M2YqgiUc6YpIquHhBdjF1Vk199NJ1htHxMVxb0DOqxUux0s6JamOpseYruahO/DKZ
 kk87v5yRQjCIl9hkpKb4FW8/26SzYqIPdxnVcmFSEvIamzWpLLy26k2A/huP67GUteXUH6wuSdt
 3/2YAfC+qF8zfww58qnvFyQ4MN3elP6ZSezyagtGNunDHxxU8rH4YG7llgsixqQ6BPQChTiSTvX
 Dl2BDYxqflrJHnoolNao4ysEId7Z6dkK+UZuQ6RKltjdArSJshv7dIQXT8j8NheeRjc2SGQ==
X-Received: by 2002:a05:6000:2382:b0:3e8:f67:894a with SMTP id
 ffacd0b85a97d-40e42502e84mr11314095f8f.5.1758989370172; 
 Sat, 27 Sep 2025 09:09:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0wAV+BTTw4kyugCbVjra9nR87tUlK7uaYk/sXSzvsor2eR69YZnVSBGAiz+NN/1ou1x45aw==
X-Received: by 2002:a05:6000:2382:b0:3e8:f67:894a with SMTP id
 ffacd0b85a97d-40e42502e84mr11314079f8f.5.1758989369729; 
 Sat, 27 Sep 2025 09:09:29 -0700 (PDT)
Received: from ?IPV6:2a01:cb01:305e:3128:cc60:67bc:12c9:1f8e?
 (2a01cb01305e3128cc6067bc12c91f8e.ipv6.abo.wanadoo.fr.
 [2a01:cb01:305e:3128:cc60:67bc:12c9:1f8e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2a996e2fsm173768255e9.2.2025.09.27.09.09.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Sep 2025 09:09:29 -0700 (PDT)
Message-ID: <f6cf4662-20ef-4740-9881-1441e1be16c9@redhat.com>
Date: Sat, 27 Sep 2025 18:09:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] VFIO: cpr-transfer fixes
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com,
 steven.sistare@oracle.com
References: <20250926022348.1883776-1-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250926022348.1883776-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hello Zhenzhong

On 9/26/25 04:23, Zhenzhong Duan wrote:
> Hi,
> 
> Patch1: fixed an error restore path when virtio-mem is configured.
> Patch2: fixed assert failure on error restore path, this issue happens
> no matter if virtio-mem is configured.
> Some trick is played to trigger the error path,
> see https://github.com/yiliu1765/qemu/commit/494d19e7f7242dbc47d7f236937cde0c396a4a7c
> 
> Patch3-4: issue only happens with two or more VFIO devices, no issue
> if only one VFIO device.
> 
> Patch5: SIGSEGV if I send "query-balloon" to source qmp monitor,
> I'm not quite sure if it's deserved to be fixed, as guest has been
> migrated to destination, it's not a big issue for source qemu to
> SIGSEGV?

A large series renaming files, structs, etc. from Mark has just been
merged. Could you please rebase and resend ? Sorry about that, I wanted
to get Mark's changes in asap.

Also patch 5/5 seems disconnected from the email thread.

Thanks,

C.



