Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307E8CE7AB8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 07:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smTpy-0006LG-IE; Fri, 06 Sep 2024 03:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1smTpw-0006ES-Qr
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 03:56:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1smTpv-0002eY-Dn
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 03:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725609414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m8xPDxan9kn5n+pJE9KZXuObFz3+4BUdmZXQk4DHTxA=;
 b=GFuAoWiIOfxoEwyGdPgV/5qJi9ijkwS1PckB3VrkFZoq4bA3GjMVo3mbgabOcypgGrYfoM
 nfr7rbuEf6lsUM/pccvExnZaiAVrPaDbN7+W4rUQOxb8nngg51eXBfSO7gxh0e6TMgW/Cn
 L47h8dN1fwGRgydGldfE+JTiVKt7XXo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-bT21vrBxM3KhQilCiYv5pw-1; Fri, 06 Sep 2024 03:56:53 -0400
X-MC-Unique: bT21vrBxM3KhQilCiYv5pw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3771b6da3ceso1024453f8f.3
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 00:56:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725609412; x=1726214212;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m8xPDxan9kn5n+pJE9KZXuObFz3+4BUdmZXQk4DHTxA=;
 b=Tk8VJtbCdMbChH2yDcoL92XYBGrkQ5cPiwlEv7r45h6VAtRJY1odvI2vgGevieRoqi
 OsJy5elJHsvAjqa1peTKm3XVFMhKxB2KNSVEsGPnwbVbFYBPMQ6ZnMgyUT0JaPv4Hg67
 xI88IMEGr5vbypKzrG80c2wDNFfleiJU21XGEwhx+CpLarS3lyWYS58qHX6lKLXyd4PG
 YGcz2MaMrw7D9np2teIt5IpJQXzCDw9eoOxjRw9fY2l4wA6QdKZlb9zx9GXEReWrzA0j
 W9XOnblIU95u3dDfeEGpsHT1Z8XG4cF5f4nFFEc0A5pAK9RG1Vo1dDGmPdhzNbK5v3HU
 H5Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ/JHIoLy2UpNo1yFtdCbmWonlipuC2Vt+v6+a5TxCaHiNh9L4bSgarOp+781ghqC/RiaozVOk2xQT@nongnu.org
X-Gm-Message-State: AOJu0YwE25dKAjFd8HlAnscs4ZZodif1207B4YxpS64mbxgTSUkgqCiM
 c816z/6lmhy7jRobmX6dBPOG2emsOxrsVF7gojSLvJE39KcKnY3NmJUd/lMTP3aanVKgQRT5g2u
 uDO3RCatI7c4TZfIki9WB6tZ10DzRrc5ZHe8IEDqP5WR7ed+VNFsNBKMiWJ+zOiS5NSHZdrTd28
 a/36o3jM3GcGhjfwXm82jnHsNfqzM=
X-Received: by 2002:a5d:4088:0:b0:374:c31e:9724 with SMTP id
 ffacd0b85a97d-374c31e98c4mr11784183f8f.10.1725609412150; 
 Fri, 06 Sep 2024 00:56:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQjvLY8uarg3Q85DO0jkeRAWzPKfqvb3+Z9A97XLxvsCalI+j4AUerUwq2Z8y8RV2fUG+uXNya4bO/Mwm4IyY=
X-Received: by 2002:a5d:4088:0:b0:374:c31e:9724 with SMTP id
 ffacd0b85a97d-374c31e98c4mr11784162f8f.10.1725609411646; Fri, 06 Sep 2024
 00:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240828-rust-pl011-v9-0-35579191f17c@linaro.org>
 <20240828-rust-pl011-v9-7-35579191f17c@linaro.org>
 <871q284wxk.fsf@draig.linaro.org>
 <dd2ed180-3624-4981-adb7-c78e699048a7@intel.com>
 <87y14e1de4.fsf@draig.linaro.org> <j2qtr.bznhnwg3r4rn@linaro.org>
 <5676887b-9e54-4ee3-a29a-4735c3c21350@intel.com>
In-Reply-To: <5676887b-9e54-4ee3-a29a-4735c3c21350@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 6 Sep 2024 09:56:40 +0200
Message-ID: <CABgObfYfuARZBHkx9JQmP8h0XfUevD-Xi+KorqBA2Au9LRMVzQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v9 7/9] rust: add crate to expose bindings and
 interfaces
To: Junjie Mao <junjie.mao@intel.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 =?UTF-8?Q?Alex_Benn_=C3=A9_e?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc=2DAndr_=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang_=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud_=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Sep 2, 2024 at 7:59=E2=80=AFAM Junjie Mao <junjie.mao@intel.com> wr=
ote:
> +      '-print-file-name=3Dlibclang-' + host_clang_major + '.so',

Note that libclang-MAJOR.so is a Debian-ism. On Fedora for example I
have libclang.so.MAJOR.MINOR instead.

Overall, this is a pain and I'd rather leave it to Meson developers to
fix it. Until then, you'll have to make sure your clang/libclang
versions match, or pass CLANG_PATH/LIBCLANG_PATH.

Paolo


