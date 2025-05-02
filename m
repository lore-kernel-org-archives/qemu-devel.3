Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54493C3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 12:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uApW8-0007vK-H1; Fri, 02 May 2025 08:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uApW1-0007uM-Nw
 for qemu-devel@nongnu.org; Fri, 02 May 2025 08:29:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uApVy-0001UP-Er
 for qemu-devel@nongnu.org; Fri, 02 May 2025 08:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746188952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pyhtS2uCUy7iL3ya9hKovSx5GvTB1tKkzenjMRuLgFk=;
 b=UgriJQf4rjpir1EQg3SLEUms8jfIE2id3goeC7JLaf9vHyRtLQnfRpEbxNvpeVXcyOGqBB
 23i9FXnjRYXftK5VIpZwd80NDC7uzpRPnyv3SkjzZBBiVbNR71D8WGDX7nJ7e8lv7s1Dn3
 8stj1Vf91r7E3fj4/576qRmnp+qTs/c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-iIHUKO4bPSipYZrVG4iw3w-1; Fri, 02 May 2025 08:29:11 -0400
X-MC-Unique: iIHUKO4bPSipYZrVG4iw3w-1
X-Mimecast-MFC-AGG-ID: iIHUKO4bPSipYZrVG4iw3w_1746188950
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-391315098b2so605586f8f.2
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 05:29:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746188950; x=1746793750;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pyhtS2uCUy7iL3ya9hKovSx5GvTB1tKkzenjMRuLgFk=;
 b=kXi1ORN7s8Cr7dotoZgF20gH56MIgDhfgYz0tsGbO8K9t7ytbi1JIthtxddMkMafE9
 XmSLx5qtXjOaZ29ki70r2VngMOcC8wjdxKhK9xzXqdLtb+fLPtvjH1efiyz3HF+gazgt
 jk0M8Yc8zh8aai/XjJ95jGZVR15K8ZsUTA+tu1//z3+oJa00OF4ZDje8totvOJb+7Cmf
 mwDXaukBiqLYBbsPW+1QMnOvNkjUNOnB/M0yNdkx3+bfavCQ6k/OhRZ7ynlsXV1pdSwX
 8UAQimeC2Ylg/7esFNA9g5gI3cvGHJ51dMEbH4j3g4tf8S851RH7467nHeoUs+xupUHR
 A2Wg==
X-Gm-Message-State: AOJu0YzxDkTdsPOqXpmdBQywdq8Duf7raqgVN/u2ive9rCrq2dXiEXKY
 IXDtPbbbtV1rgqKCUE1gtdYqDTFfARwFzfl1k2afISmjCY0K2AkUFnKE5GNJc7RaNuz0Wacje/Q
 kJOuRrieTF/UIMjZ7/8HIYu8DHv3LEhEFBDrCLV5mZ+ehgH6nLHSmHmJvYqEyTr5YhFR0CgrCXQ
 pf+h948R63P7ILm4lYEzXxuZsjKIc=
X-Gm-Gg: ASbGncssBasBy/0SCyRJSO0HV28oRg5FfWQVHFXVr8oJXqs1/Gw9tWIEbVG2LjVuph/
 KT1wjTGlB8roDrZLalcaLKGRoty+AlU5N/NPMcOY9pZsc8377CqJpVsBlPfOgcpYQX3+9
X-Received: by 2002:a5d:47c7:0:b0:3a0:8311:c455 with SMTP id
 ffacd0b85a97d-3a099add09fmr1806096f8f.34.1746188950092; 
 Fri, 02 May 2025 05:29:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLZFlXf2lp9WA/tIQsBsszXkbG8qf9GAk4OoktKQF2lvQtV8y2sjv5VTLhLKD7tyhP+kqMvJr1F1qOsdeAo2Q=
X-Received: by 2002:a5d:47c7:0:b0:3a0:8311:c455 with SMTP id
 ffacd0b85a97d-3a099add09fmr1806077f8f.34.1746188949766; Fri, 02 May 2025
 05:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250502102323.104815-1-pbonzini@redhat.com>
 <20250502102323.104815-9-pbonzini@redhat.com>
 <svmsie.1mbmcen6stmg8@linaro.org>
In-Reply-To: <svmsie.1mbmcen6stmg8@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 2 May 2025 14:28:58 +0200
X-Gm-Features: ATxdqUHmrHkquSDScmWwvBBSLl3MuJcS6CMNjeLmb6gUUc2uUyRtb8V4OXi-UdI
Message-ID: <CABgObfZJ0Jvxwdd7T2VjAkiYA90SyfSqy-D8OO4ZYp-2wMtwOQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] rust: enable clippy::ptr_cast_constness
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
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

On Fri, May 2, 2025 at 1:13=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
> msrv/rust-version bumps could instead go in the patch that also updates
> meson.build version.

Good idea, I was mistaken that ptr_cast_constness was already enabled
by bumping them, but it's actually default-allow.

Paolo


