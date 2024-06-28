Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF08C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 21:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNJUb-0000vY-9Z; Fri, 28 Jun 2024 17:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNJUX-0000uz-FW
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 17:50:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNJUV-0006gx-T1
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 17:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719611446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yiREuiBF2CWKjCaGO0V/8PVFM3oJ0ruPBPODFaeIknk=;
 b=PvcKuyB5iNGBzMruluVcFs/YgP1CUOlYDQ8310OO+XEbZyvsfeRJHjHUuILcFWhaG2RDl0
 UDtOEkf3KrsHCh/kXgta5SkVtPwIelayJVpyVUf4oJ8yrmYgxYPhi3gKbPGmgBRTciPBhd
 NGeGuMgF8Vn9F5vsjaQ+Xxma7icpD+8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-a3J3mOZxPKOXScHaVdrWTw-1; Fri, 28 Jun 2024 17:50:41 -0400
X-MC-Unique: a3J3mOZxPKOXScHaVdrWTw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3625b8355b5so877330f8f.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 14:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719611440; x=1720216240;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yiREuiBF2CWKjCaGO0V/8PVFM3oJ0ruPBPODFaeIknk=;
 b=QSstpnMUyIW1sa5IDhWGmD5BaCe6LusNpYaxZIFoLstGb0xSZpRrLTQdbjsb2MA0fE
 C2bLAYFEBhGyGhtZHs069fvWDVE/cSig6eIV8IUUkp94HbqPPP+u37HsieIMVUI4odFF
 F0ebDVFbc6SKgc9TUQjteEzHZrWbboicislQfc/PxlEmj93GXZhWNX3YBYr1sdXuZo/W
 THLrzGNfAVACFsDeBOjOhsC+PhYTRGZUlp8y6+zBbaUhSPGaJodO1zddnlDWlJ8xek7l
 fopzkFKKEtCO3tW2KGD0cc63e6c5rUaeKjVx43WqESBbcPqJIGsz9gqPW1CdPRc9LrEu
 GJ0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW09sxjKfbNBgXF5Y7293hhcqMaSKfgZDaF6xuFodMKaRbdN1ktfosdPPBIRKXYKR8A4nEYwCJkfkjKmFb6H0gyi3O31gQ=
X-Gm-Message-State: AOJu0YyzNkaeJHPlbqC3NY3lAQ2TsxCz9kmSk90xHF5Qsz+Gb1clO6Ib
 db2m1FgTffHLGqIe7LwXpGQzKKKRojs/AAnuRZTilKzgx24bQpszOxXZZnd+baq2V84J/+q/ujk
 uNfRbhqxE126y4l+5sztoIWJBzIJchK7J5EeDr/3rcKLgwli2xrYZiuFGiUuFAycp59HW+w9J+f
 Br22md7AbVfvwI3iyl5J3vlB1ksEg=
X-Received: by 2002:a5d:6dae:0:b0:367:4337:3b35 with SMTP id
 ffacd0b85a97d-36743373cabmr7133587f8f.63.1719611440318; 
 Fri, 28 Jun 2024 14:50:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMvXT3YgdGYYecO8xl0ra5NNGRJLU6BJw55kqcKHhcYqvjbnac1U6DW8nhHziRfbP3OAsufqZWu7blHVSu3nM=
X-Received: by 2002:a5d:6dae:0:b0:367:4337:3b35 with SMTP id
 ffacd0b85a97d-36743373cabmr7133578f8f.63.1719611439996; Fri, 28 Jun 2024
 14:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
 <6bf311a35e6d3bfa8b3bfd10d8f896a9e655fa30.1718827153.git.manos.pitsidianakis@linaro.org>
 <ZnlGlOGORQkOsoO5@intel.com> <fl60u.ry7sk6d8fv39@linaro.org>
 <ZnrpgW+CopiJAGZF@intel.com> <fnew7.3urdmuxnhe3l@linaro.org>
 <27f52dce-b659-446d-8358-50b6001f7307@linaro.org>
 <dfa7bc8f-378f-4876-b630-fe1182dca937@linaro.org>
In-Reply-To: <dfa7bc8f-378f-4876-b630-fe1182dca937@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 28 Jun 2024 23:50:26 +0200
Message-ID: <CABgObfYOE0HsmuCmHauOPDVpz2Og-jixkV7iHYSgkg2zmaahXw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/5] rust: add bindgen step as a meson dependency
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, 
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn_=C3=A9_e?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Marc=2DAndr_=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud_=C3=A9?= <philmd@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, rowan.hart@intel.com, 
 Richard Henderson <richard.henderson@linaro.org>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 28, 2024 at 9:12=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
> However, even tough I can build the executable, I get this error:
> $ ./build/qemu-system-aarch64 -M virt
> C:\w\qemu\build\qemu-system-aarch64.exe: unknown type 'x-pl011-rust'
>
> Any idea of what could be missing here?

Maybe the underlying mechanism to invoke constructors is different?

Perhaps we could use https://crates.io/crates/ctor instead?

Paolo


