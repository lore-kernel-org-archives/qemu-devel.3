Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72151D3E79C
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 08:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTbxM-0004nm-BO; Thu, 11 Dec 2025 03:23:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vTbxI-0004mr-Kt
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 03:23:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vTbxD-0002fU-0I
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 03:23:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765441391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q7Eh6GuxjUuoNiMtr1AQCAtB3vT5qUEJV0dSCq2Biys=;
 b=VBpy3fNpJP0dd1UQUViImFu7lzhryhfU5Ln/cR/OaTEcdP/yTTlcX/xL67T96Dzs6QlF6P
 AZLl7iG33yvvoqueVmsFktoFMhSP680No5yeBIRcsmXf6MpY1x0rAfhov7cTtrNLnLrN/w
 KBYHl0szT7nY3IC97/b4qKFizztljnc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-eIu-UKWFOwi5RmUL3rceSA-1; Thu, 11 Dec 2025 03:23:09 -0500
X-MC-Unique: eIu-UKWFOwi5RmUL3rceSA-1
X-Mimecast-MFC-AGG-ID: eIu-UKWFOwi5RmUL3rceSA_1765441389
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-297df52c960so15502605ad.1
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 00:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765441389; x=1766046189; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q7Eh6GuxjUuoNiMtr1AQCAtB3vT5qUEJV0dSCq2Biys=;
 b=VMZ6mXz4OsP6eKk9IJ6F/+CbhR/cTJAYjdDH86zDHDrqLQIMF8ANqo62fP4RGCXRmq
 EP/eIVzolW1xXR7k8tLt+0rQS2cOX17t0qu/QNOIzp9rMh66WYp4XmLBMdi1awsPbkOa
 gQYDARZJ+4ClhawKEGNHU10JrmQbXbF+0IOUwuYFRXVgpeH7HxHQ5mGAdAgtyhXONNzV
 gZxEgjFezcJvKLVrFCARBunOiOmlvOB05gc2Lg/9XhwFr+JApVd2BKBJ0xVyDbGWJukM
 63MoibzADge5N5E76tpXAk9cMHco9gugKYIqENbrrQgMn9cLmOHG93XV3fF3EWeTzbDe
 zr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765441389; x=1766046189;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q7Eh6GuxjUuoNiMtr1AQCAtB3vT5qUEJV0dSCq2Biys=;
 b=ZHQ8Hw9jvXcjw6VWtcwJMY/rW3jTvbLMJlnOZOOtbb5ZzX903QBVl9zYnZnJAaqe5r
 s39pUugrIFQk1R9t6QmxeBxVBUwCdvPMTNrnv3qpOUyQfDmMHF7xVXXZo7F37g1kqK6d
 llncDyZGFFNRCG4Fwxj/JKUwjI7UQt1z7tj2wzS1nQCIe+U7kY+C6zUCf5JL/qFUKlcd
 lySbN4d7vpbdVxbjIodbcLk9qf632BbDQ1WMC4F+aLdFuuE1veR38DQ3DEUO83eAkLlZ
 /PWHQdkQniaReROGPIN24Pg4qiSpPsMOZ+JUG74yli4PBKnGPJpzIYJOEyxic6FeBa3j
 vNBw==
X-Gm-Message-State: AOJu0Yx+RBotvokFYUnhYHZL2sNWuV9aKUUqRwkeqwZvfuXNSns533iu
 kFSbhThwvLgL0IHekFF5HwBqYTxLBWaAhWSXbFLN7tEoPS6bw5pVmn4OASJr2IcgaSUzqmWC9CO
 vvEbMb4m39rJb3mjF7rjflySxLwc3yOll7o58cHXPNbBMf/xeQflDaK39V/Wj0rXkId4jK9IpKo
 t/j+3/xhqdNikqpA8iqkV2f1lBKYGw6so=
X-Gm-Gg: AY/fxX7K3O3nYkY47GfLL1lmOsPPvu7NgHjBYCQCUCj8j7QTFEXJ4EgfpdGyriV39op
 p5dGo3awM23V+LGaRwywXSGFa6AT4/9Xqy0teLzceInQujqkntjXcgYJOFMrxc7B+fj+/GdN2dY
 NJO4CYU0thls63Z5fnPOH0F+ZJTurCVe2pwq9xESXwsyIs5ud9usiQc9wJukhWVLs=
X-Received: by 2002:a17:903:38cd:b0:298:6a79:397b with SMTP id
 d9443c01a7336-29ec27f402cmr55117135ad.56.1765441388707; 
 Thu, 11 Dec 2025 00:23:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFo9j1zmB8UAFlypvVIz0RGBw5sDhBWr4fBArkCBFuHd+8fxnLYSThfmUvaejeC8SYECVPo0ABeQ7wonQYc6WI=
X-Received: by 2002:a17:903:38cd:b0:298:6a79:397b with SMTP id
 d9443c01a7336-29ec27f402cmr55116925ad.56.1765441388335; Thu, 11 Dec 2025
 00:23:08 -0800 (PST)
MIME-Version: 1.0
References: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
 <20251117093729.1121324-3-zhenzhong.duan@intel.com>
In-Reply-To: <20251117093729.1121324-3-zhenzhong.duan@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Dec 2025 16:22:54 +0800
X-Gm-Features: AQt7F2rI7HQ3UX34cen4_J4RCup3w7aO4yj0ZrWsmaHEKQL2X0QiTRqEjCAGLR4
Message-ID: <CACGkMEtK_KiT+PCvxi2NUQ-gX0ekV3RtZ6E5T7oZSeiOqkSSkw@mail.gmail.com>
Subject: Re: [PATCH v8 02/23] intel_iommu: Delete RPS capability related
 supporting code
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, alex@shazbot.org, clg@redhat.com, 
 eric.auger@redhat.com, mst@redhat.com, peterx@redhat.com, ddutile@redhat.com, 
 jgg@nvidia.com, nicolinc@nvidia.com, skolothumtho@nvidia.com, 
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com, 
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Mon, Nov 17, 2025 at 5:38=E2=80=AFPM Zhenzhong Duan <zhenzhong.duan@inte=
l.com> wrote:
>
> RID-PASID Support(RPS) is not set in vIOMMU ECAP register, the supporting
> code is there but never takes effect.
>
> Meanwhile, according to VTD spec section 3.4.3:
> "Implementations not supporting RID_PASID capability (ECAP_REG.RPS is 0b)=
,
> use a PASID value of 0 to perform address translation for requests withou=
t
> PASID."
>
> We should delete the supporting code which fetches RID_PASID field from
> scalable context entry and use 0 as RID_PASID directly, because RID_PASID
> field is ignored if no RPS support according to spec.
>
> This simplifies the code and doesn't bring any penalty.
>
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---

Is the feature deprecated in the spec? If not, it should be still
better to enable it.

Thanks


