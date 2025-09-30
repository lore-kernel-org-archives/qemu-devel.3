Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE1ECCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 14:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3boW-0004Zy-UL; Tue, 30 Sep 2025 10:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1v3boU-0004Zm-Qw
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 10:58:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1v3boO-0004ca-Py
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 10:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759244313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SsfiDV8C1WlF7ZQDJ0L2SmMQ5v8t5nGH6NWcwKMIy6I=;
 b=cpealbIjBlDztWHIgfXBc2qSITUcyjiXQh8Ok0/R1POE0lVHlZs8O5Ojew20SIz4MFo//R
 wwKS3d9O2zOueXaeeqibXsTCo9437kvA7fF+Et8qrAPyql/+7yyaT0YVuvablPkOb2xX/V
 L9bX32mf0c+u3aaWUSkFdCVYdstiNvg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-YKFW4dM5NPuq39HVsxKNIg-1; Tue, 30 Sep 2025 10:58:31 -0400
X-MC-Unique: YKFW4dM5NPuq39HVsxKNIg-1
X-Mimecast-MFC-AGG-ID: YKFW4dM5NPuq39HVsxKNIg_1759244310
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3f6b44ab789so3558565f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 07:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759244310; x=1759849110;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SsfiDV8C1WlF7ZQDJ0L2SmMQ5v8t5nGH6NWcwKMIy6I=;
 b=XlFCbDtcqUqlpOW8DvLkRfHh7cnC9+0qnJpcXc1lLfEqaeu8HAyrnn4lFacDwKj3FA
 SEQpV6RDQ+737Rc6KI4raY0NCyIVWf5gnhkvw0+NLJGKA5sYeMtoFQkzExZ+Z0ZKU0p5
 BrT60VCVZ9qTcNjcyhFq4M+FMbapdyEgsjKC31VVELot5Hjh29oJk94DnD9Zlm0BRVpN
 DvQWMN2HchTZ70+fOqj0hUGk+OYcFzpsnAknBl5unGIZvhnDWFEvZ0joYVPu10aujytU
 mrg5SoKHqR6icayMstaUi5AeWImzXgwVWlTm3EdznPYGxIbODB5IwW7Cu9ifnpxtzXxm
 JWiA==
X-Gm-Message-State: AOJu0YwDvKmLsPhLJY0BZVPU/wv2pjMAMEAOFQKe22oa0OvV1fA5vEIm
 VWyvQWClGDlP+Vb+jLu0nBsX2Uzfs6Gs2Xlbzmu9ADdiliWjxzQSXk7ykEs3lKYRWBf0bDA4P+I
 SEvBbdyAiEnK5BV8oqxnavdVucOUeHSaFr/36W05hv9++vkA+dPpT9EyG
X-Gm-Gg: ASbGnctHQwYBQTX7RwJF2ajtarkdkab30BenclmXj466aUYyKVbknzKVhuaWzL1Q8lf
 AiQe0zD0c2R55FZrtJi9iVdO/hzPDiiCnYGX9qseLfJluVvWpWgLsGvzHtiTm/vFMIBIfZn3ARe
 M8ni6A6y6ta7xt9zyNWN2KZStAItDYAkX9RsDjX8Y+itDM0i9a66bdbF/n8ugoqZk8Lq5o5d27+
 WjZvK/60wqS9GvJVuRwvEv9C1YuztwGAjQvhMUVWg9I+2dtqpeEbGSqL/zn5hJ2+2q0nU0XjO1h
 dR0sLr1zDnz0unX34EXb/EzHv+MM6eGApXuI6JA7S9BOYwovgB0bNU3o3hTRynVUTxU0EGYeqKA
 1ziMxi3pEyMJ6Jd+IWQ==
X-Received: by 2002:a05:6000:240a:b0:402:d5e6:2283 with SMTP id
 ffacd0b85a97d-425577f32e6mr50660f8f.20.1759244310341; 
 Tue, 30 Sep 2025 07:58:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3+GaVinEUlBA9M9+U+KLiZbdyC4+ZeIn7JXaxSlVoMQp79/GTqtwtssveBbS8CM/Z19kjKA==
X-Received: by 2002:a05:6000:240a:b0:402:d5e6:2283 with SMTP id
 ffacd0b85a97d-425577f32e6mr50632f8f.20.1759244309896; 
 Tue, 30 Sep 2025 07:58:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c?
 ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc72b0aeesm23582002f8f.49.2025.09.30.07.58.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 07:58:29 -0700 (PDT)
Message-ID: <d2b413eb-ed0c-46ca-a825-a29cdac9e5f4@redhat.com>
Date: Tue, 30 Sep 2025 16:58:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/14] virtio: introduce support for GSO over UDP tunnel
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Lei Yang <leiyang@redhat.com>
References: <cover.1758549625.git.pabeni@redhat.com>
 <CAPpAL=y=4=OmyX+L16Kd1a_3LLrRqfWUQxf9O50hm=M6AG=_7w@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAPpAL=y=4=OmyX+L16Kd1a_3LLrRqfWUQxf9O50hm=M6AG=_7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Michael,

On Mon, Sep 22, 2025 at 10:21 PM Paolo Abeni <pabeni@redhat.com> wrote:
> Some virtualized deployments use UDP tunnel pervasively and are impacted
> negatively by the lack of GSO support for such kind of traffic in the
> virtual NIC driver.
>
> The virtio_net specification recently introduced support for GSO over
> UDP tunnel, and the kernel side of the implementation has been merged
> into the net-next tree; this series updates the virtio implementation to
> support such a feature.
>
> Currently the qemu virtio support limits the feature space to 64 bits,
> while the virtio specification allows for a larger number of features.
> Specifically the GSO-over-UDP-tunnel-related virtio features use bits
> 65-69; the larger part of this series (patches 4-12) actually deals with
> extending the features space.
>
> The extended features are carried by fixed size uint64_t arrays,
> bringing the current maximum features number to 128.
>
> The patches use some syntactic sugar to try to minimize the otherwise
> very large code churn. Specifically the extended features are boundled
> in an union with 'legacy' features definition, allowing no changes in
> the virtio devices not needing the extended features set.
>
> The actual offload implementation is in patches 13 and 14 and boils down
> to propagating the new offload to the tun devices and the vhost backend.
>
> Patch 1 is a small pre-req refactor that ideally could enter the
> tree separately; it's presented here in the same series to help
> reviewers more easily getting the full picture, patch 2 updates to
> linux headers update script to deal with annotations recently introduce
> in the kernel and patch 3 is a needed linux headers update.
>
> Tested with basic stream transfer with all the possible permutations of
> host kernel/qemu/guest kernel with/without GSO over UDP tunnel support,
> vs snapshots creation and restore and vs migration.
>
> The new features are disabled by default to avoid compatibilty issues.
> They could be enabled with a later patch, together with the related
> compatiblity entries.

I thing this revision should address your feedback, please LMK
otherwise. I'll follow-up with the FEATURE_ENTRY() macro cleanup as soon
as this will get merged!

Thanks,

Paolo


