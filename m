Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0448CF45AF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 17:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfLTs-0004bq-LU; Mon, 12 Jan 2026 12:13:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfLSz-0003jH-V4
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 12:12:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfLSy-0007hg-I0
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 12:12:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768237951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n4FjcWu0LDKcBLtXzBHQQcI0QgAYGSeNNtKSt3IpPOU=;
 b=dHodj+s3jQE9r61FhBHPJMdiOrOBgrcIQC8pZ/7VpdVmaLNFFNNmNe2egV36ZGEXPOiRKO
 yQXgfkTC6uXrMZkaQIGS12Pl3279e1lgDpKB9IurZnw1JJWF4+EFg8po+D1oyL7OGWBU6E
 lbhTtpn+sJioJd4sehY4I0rQnVTofSQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-0ZE__jkfMtq5ijkMb2FwmQ-1; Mon, 12 Jan 2026 12:12:30 -0500
X-MC-Unique: 0ZE__jkfMtq5ijkMb2FwmQ-1
X-Mimecast-MFC-AGG-ID: 0ZE__jkfMtq5ijkMb2FwmQ_1768237949
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47d5bd981c8so45878895e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 09:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768237949; x=1768842749; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n4FjcWu0LDKcBLtXzBHQQcI0QgAYGSeNNtKSt3IpPOU=;
 b=ZfDVOEd64eQhYYRvdELM0O5qNFUKGNeOgldGOxB/7F3QhlH+JPECKIoGioJ+8juci2
 /XzpPODM9wZ/m537klngcDxlK23vZplihtDs5hDs3qVxdVcQoo8NCNdqQk3MpijFFIBG
 blPi66mR3ihv4GgzhswZIwRPYZikyxaRiwu/rPoommMgKSBHSidB+25f9eOYFc7aKnhb
 /TfjgCKMj4bKwFK5eDOWN87BhkkUnTm22ASKPlt46ttOdBOFSIs1RyMokZ2zI0UIiOFC
 nfb1ZZqCIkQwqOmGBNP7blnZXCuBqoI9EHtJVy7rT9wf12YYyKYTzyzv77gGydHEE+A3
 hK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768237949; x=1768842749;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n4FjcWu0LDKcBLtXzBHQQcI0QgAYGSeNNtKSt3IpPOU=;
 b=K9q8PTHAS42sSvKEwCe9sl3FZ4hqep+Sz4hKyKkwsRT98M7OoEqkDzm7hSeKi+cqEq
 eBttVAfiinymhThgbNalwZCeyp+P1lXUxF8FmkRE1E758wud3K61ni8OVwgFD99P4Uan
 TtuQM7ygEYhyNnVjJOb2A0u4j0XSYl30BnlaQwi0frdYQscfp3fPBOQB6kuasnzCH8rF
 6trRdvhpFY/8IsBJyVoectaGnx6Y3PDRY6Xe7Sk/5+wJZmNf024pG7Ogww+RTDlF6qKu
 QuiGi8tNrEygNhwp89Gt7yUcz2XIbcq1hrGM29S2heokyXO7SP20+wZOUe+x03mxw3AX
 0f3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGaU/QzuSS2aOTVbBQopn/yg6ovqIuXuHCpG3+AE4sn3OllulEf58IdcHH99IND/KuywkUgi1jXrWp@nongnu.org
X-Gm-Message-State: AOJu0YxUtA/xD7cSshuoyRis71J7sjsW+93ynRcYMa+C040OA+lvg4uz
 hEnygmTcCd/fwe1KVMGnvHHLthsjyZ2fdoj8jgvmMcb75ksU/LBNDqq6IUczGICg+8OiXz6hQLW
 Ccpuy+APeKnjRPch/pDiw/RNBxl0DmcJD+QkXYvWQEPjKo/KjbAFaT4BeuHwxNBxRQoexvJ+N1d
 Ucu5Yyp6faXUy7LiT+PkuaoYaajMEfUDU=
X-Gm-Gg: AY/fxX7kWQoV2Wxz9YCf1vdHCMt0ZlrqfjFl2HH5s3U93Xo2YKfbFx29r7JhviCpGd1
 1V4s7NTHZg4gESex/SbR6nedZEsjizRyNdqdLs84nHVHuxn7JXulRdylnhbyYUXVUU9fHGQj39c
 WOg/Udp9oYxJYVfnWGt+hEnpXGV7rKnGdBDxEieYHuafqBNb+cacV//a0qjvIyrxSioqVkvwMRh
 nnDymwmzo7T/uMdv9LnJ7XDYaTRzR8TpH32wzGqRnMA87p0YM2dafUSsq04T17Q7YhAWg==
X-Received: by 2002:a05:600c:3e8f:b0:477:5897:a0c4 with SMTP id
 5b1f17b1804b1-47d84b0b315mr198969975e9.4.1768237949085; 
 Mon, 12 Jan 2026 09:12:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+VhlfxTBklsMUvnB2bwD9d0SVSG9i3WldYSftXmzGMnTRQo6eoyUW1AqgCgPVrhVKsoZhsI9d3anZTvrNxc8=
X-Received: by 2002:a05:600c:3e8f:b0:477:5897:a0c4 with SMTP id
 5b1f17b1804b1-47d84b0b315mr198969675e9.4.1768237948726; Mon, 12 Jan 2026
 09:12:28 -0800 (PST)
MIME-Version: 1.0
References: <20260112132259.76855-1-anisinha@redhat.com>
 <20260112132259.76855-20-anisinha@redhat.com>
In-Reply-To: <20260112132259.76855-20-anisinha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 12 Jan 2026 18:12:16 +0100
X-Gm-Features: AZwV_QjXKzvoLIMEpw40RsKeIM2DnH2rFQQH12t1B2CQDOBP8aJHQrSn88CGaco
Message-ID: <CABgObfYgKFuBJRAR-t+gU2cUu3nVjy3++3R-k4_E+dti4E5XLg@mail.gmail.com>
Subject: Re: [PATCH v2 19/32] i386/sev: add support for confidential guest
 reset
To: Ani Sinha <anisinha@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Jan 12, 2026 at 2:24=E2=80=AFPM Ani Sinha <anisinha@redhat.com> wro=
te:
> @@ -2758,6 +2807,8 @@ sev_common_instance_init(Object *obj)
>      cgs->get_mem_map_entry =3D cgs_get_mem_map_entry;
>      cgs->set_guest_policy =3D cgs_set_guest_policy;
>
> +    qemu_register_resettable(OBJECT(sev_common));

Same issue as previous patch.

Paolo


