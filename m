Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082D6C71157
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 02:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQzvN-0001xq-5S; Sun, 15 Jun 2025 22:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uQzvH-0001xO-Ug
 for qemu-devel@nongnu.org; Sun, 15 Jun 2025 22:50:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uQzvG-0006Zd-2t
 for qemu-devel@nongnu.org; Sun, 15 Jun 2025 22:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750042205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kSYhpbrqtRAscdmVEf8CJRYlBh/BmBMVkp9ZZCN4XOQ=;
 b=Ohrky7EDgTiBziZuug8mzZ4ajUCAnrMkxg1PKKh4ryYBZWVad7XrAQ/wg+f0pORyST8yuA
 Dgkie5mw7N5M2QeXuFwmjiIDkRd31WLLa7HRdBSmm2b/jnsbta2TMf04cMbiWnrfaDAoa6
 27/WFr5uoRXYLmyUuotP6NIXtdzx9WM=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-5ToYK89aPOCNBqGDDSAyWQ-1; Sun, 15 Jun 2025 22:50:03 -0400
X-MC-Unique: 5ToYK89aPOCNBqGDDSAyWQ-1
X-Mimecast-MFC-AGG-ID: 5ToYK89aPOCNBqGDDSAyWQ_1750042202
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b2fa1a84566so2742914a12.1
 for <qemu-devel@nongnu.org>; Sun, 15 Jun 2025 19:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750042202; x=1750647002;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kSYhpbrqtRAscdmVEf8CJRYlBh/BmBMVkp9ZZCN4XOQ=;
 b=P+oKOsxcavZNsBlp03CBZHmUokfyDYicVpIdcgiGAb7PyeQXHkgRGXzeBeJy72hGTM
 1Y0U4kJ/OG5E7jS71NoJnQhSZWp0n1n5Gi+z6pLmstVLESTHgdD1J5AFTsaQe6N04PFo
 0EwM64MiBkJvMpwVVkGBvNFV3De5xI3j2HGljJ+13Tp8JkEQEXHGlhPspmUYlwbF4hxK
 k+matsrMgeKquhiH2AwWgpqpL6qyB5SLBBLD9RBtz4sL8bg+dQIg3J6WcH9AkGK8L/B3
 ZUDFPdERkLUHIzKTpWp7RQbBUaR4K1CrPeRmtMr80Zrh4QVxMrit237rKkANRYi0c6pP
 1abw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYzWYTEmQmQMKqn/rcMEr/5jMhAtnYOTXcXHUxQ7lMIByRhWJtanzVkfOzym7PiiN3wy3TKxvyEkV2@nongnu.org
X-Gm-Message-State: AOJu0YxB8vJYqxfTfnse2TJjG3UzTMyI+yuK35vef6PlRFtXcE8ICO/s
 WgWhRdD7ZNmnusYIsyXg4VD6opUrYhDid4MKQKSNPHVptiNXkJtvrKIED43C4bPMz0r3iPRijDI
 r8XBeVm37yQF753QYgVoe2tULCHASbrZBH3sr1BVOza2bCb5tlfwjaqxkrfVvMJJFrV5lhj7y9B
 /Co7O+mrtmgJEIZ/lKocolVlp5iWR09fs=
X-Gm-Gg: ASbGnctZTmP1tlnsD9VGy+Uyh/pnn1UNkd9WMSmIDiaJwG+RoL5/I4PWzveJH9MBO/k
 f1rjh/Ia/KV/ZMklPwUzJe4lreuHS+X3lk3F3Au41fii6P3gvsEjqohunM7zMMq/Rt+7WmnU53Q
 1Fxg==
X-Received: by 2002:a05:6a21:4d81:b0:215:e9aa:7fff with SMTP id
 adf61e73a8af0-21fbd598e4amr12035153637.31.1750042202407; 
 Sun, 15 Jun 2025 19:50:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEuICUt43/dkz8TczSwGrPxhwVRCvVVffry8u8i3BAQfyX+WY0z2HR8U4CYRrz40kpwNYGjx+qnHmYlxCfwwc=
X-Received: by 2002:a05:6a21:4d81:b0:215:e9aa:7fff with SMTP id
 adf61e73a8af0-21fbd598e4amr12035124637.31.1750042202000; Sun, 15 Jun 2025
 19:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250614224422.1595301-1-kshk@linux.ibm.com>
In-Reply-To: <20250614224422.1595301-1-kshk@linux.ibm.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 16 Jun 2025 10:49:49 +0800
X-Gm-Features: AX0GCFtK3V6RC1uj5Z3cmBIxy7rN-yXdydkNFyVbJGOe1dO2IQyzDhtgjzWPpKw
Message-ID: <CACGkMEvYHxRGUQ-4JtQDScu03L=K54NO+4LQ9Mnkt4env=a8Cw@mail.gmail.com>
Subject: Re: [PATCH] vdpa: Allow VDPA to work on big-endian machine
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: akihiko.odaki@daynix.com, qemu-devel@nongnu.org, mjrosato@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Sun, Jun 15, 2025 at 6:44=E2=80=AFAM Konstantin Shkolnyy <kshk@linux.ibm=
.com> wrote:
>
> After commit 0caed25cd171 vhost_vdpa_net_load_vlan() started seeing
> VIRTIO_NET_F_CTRL_VLAN flag and making 4096 calls to the kernel with
> VIRTIO_NET_CTRL_VLAN_ADD command. However, it forgot to convert the
> 16-bit VLAN IDs to LE format. On BE machine, the kernel calls failed
> when they saw "VLAN IDs" greater than 4095, and QEMU then said:
> "unable to start vhost net: 5: falling back on userspace virtio", and
> VDPA became disabled.
>
> Convert the VLAN ID to LE before putting it into virtio queue.
>
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


