Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0EDEF3718
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 08:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzWQY-0002gf-NN; Mon, 09 Mar 2026 04:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vzWQW-0002ZX-RP
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 04:57:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vzWQV-0001UE-DJ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 04:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773046642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z7H5q2bUnc1L7CwHCB7TMkJqVuSCaaGZQRfwdfma1+o=;
 b=OxBSa3sNeGbef8zj3WyyAAMmAAnNStXp9NYRcII0A3SLN5xOHCeyI76OkIivuYb6cvklfO
 xpqWCCJt9U/HBFDQio2NR5SYNbT5HnAk36c74Az0Pucl5fvMkeEAtYS2rc/p/lgWb6kpFs
 rMeOgoy7akXqLGp6Cs1Aad4tuT/XmnU=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-n62LHqc4NcOUTKxy6nZlZA-1; Mon, 09 Mar 2026 04:57:21 -0400
X-MC-Unique: n62LHqc4NcOUTKxy6nZlZA-1
X-Mimecast-MFC-AGG-ID: n62LHqc4NcOUTKxy6nZlZA_1773046640
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-829a4b6d5c4so1057739b3a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 01:57:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773046640; cv=none;
 d=google.com; s=arc-20240605;
 b=fKVn0ODR8QPWJumkFukXGkXPFRHMwhgSdIPTzGGjJEtS9sS6qm+vmb+C6oVbGXwGsk
 44GwkgCnYS244ZQ7WoClV9RhNcfOvEvtSRrRLFcxzj0hHToA4HRdXl6WF1sPsl+Yy90i
 gqOV+qShZwjatuFqcl/S1Tw6Kuq+zAO3NIJ/DpP2kicxIxqaGM+y6Hp8eoHO51PNgxGz
 alT3p+3MBc/980LbI4rOEpwo4NobBdkZ67gJVyXaN5P2rZikqBK/0efI5Y8vE8wwLTq4
 g9qoCvMtzydWVdgIGiK+VygzdmQlplEExVhy8qr0otw/bhjkXILqGcElvvZbKOR27R0I
 6x1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=z7H5q2bUnc1L7CwHCB7TMkJqVuSCaaGZQRfwdfma1+o=;
 fh=9rCAgRZzFqNjR/wNTxyQXAt8YRB1AGR74dADh0tp4w0=;
 b=Xfb5Z9WGgcSSOj2g0hB3+ZbzVS2hUfefYHaxFv1c1p0ffXNUG9Was7ikhLpiuj5YFJ
 VdL1K6yfcwkhTHntAzBeUZb+UlFx16i/vWB0FmP3Vjtqh995OK7XzvI3jRl1vb6QB/o9
 CYKo8DrnUFbfmMvtzJRKo5q20mKgWOW8ZbkaxjswpDTqS9NPWf9XDJX9ZDBM0hqNwL8r
 wUSL/ErUBVKOO14vJEzCyHctd/4tjHMz4HB8TASRrfRJXkuXz1CljImt2yNNNQoD6hzO
 xNPQUwfGHLcgxAIHrcopLrdzo4+84aH0IusutuU27CTpggf8YvGLdohYvEj+3OMeWZp3
 d4gA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773046640; x=1773651440; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z7H5q2bUnc1L7CwHCB7TMkJqVuSCaaGZQRfwdfma1+o=;
 b=H5jY/5tRSAxC6+NLecTm7vYN/BSc/O6sqv2Gf2VxVAlKymGgms4xgPVqtzUXO+CpHe
 S2dkXi2pYtaxA2hzedF76l/Vw5l1TxPsyRIjmC0mM2MTIBYHw2CnB8xGvhSBU5Jh23HK
 Ad5TtMSaCeHcm6yBvJtl/jSDXyl/MtRlyQtBlhuFQOs5jPfBCUGK88vJGNR9QwLlIQSO
 PWUNj2/5iVzOCvu4DB+Ux+kJBqqyZxz7nqrpk8YSjPsb8MUmMVzoxDMNO9bIDuP6mliL
 LBosl2iVgHwlY4wu2CjeBeu+9KWVJSNr8eJMTxs4jQY1Mo5VcJyYNAeFx7ih4GbaS35V
 WaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773046640; x=1773651440;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z7H5q2bUnc1L7CwHCB7TMkJqVuSCaaGZQRfwdfma1+o=;
 b=ZhPDZXn6U2lTlsZsKoMAcTS739Qx4kd5dKwuTKAXVHLxEZ7xwIm8noTf5A5toTpKGN
 xc++5N0nJlZ8IQkjAKrEduh1L5pD5sgrmMf3WFzooRMmGGBIaDbaQq62Cx3rimAjEWrt
 fGWvNsAmex9FD+TsRZyM5mT0mANhFztgQ93pyMSwUHerx63RCy74EtHHUtOlFkpOyv53
 NTxoPdQfd2hvzeTxGRS7axkIfJxzqxqGi9gVqHVakPqRxq6JHOD6c9qeNEErvyikFZ7z
 eYp+MPuB13WxOGMyi0UMEzk+klT3gRLoPkMYhTfcZ00orhXDCb/XXgUd7A2HWxDdUf4m
 0Zpw==
X-Gm-Message-State: AOJu0Yy0zVHQYcTUNu9W1Rh7/FXsRoihYN0YCgOUGNvJSTy8eBVkc3No
 030Q9qwJkPpoakXD+GzMrwT0LpT4UtiEZ6tDztztAE5VQO7o4qsIqCtl9qs5drkuI75xZSCUnEr
 yNvZ+o3NUkf400lRaW60KNKdKRA1FyPUSmaG3Q273KySACBlqacRLc2p9lmXfbvSf5Y0dex7851
 ERLMiao4S2cjU1liZ7TXN3Fdtp9uWIT/s=
X-Gm-Gg: ATEYQzyv5sB95boFRXGoSbYe+A17scF7geUzgqyv+JzahoVkzI7ukCGsSo9CWF9aaVE
 EWAm8fKsrOpAlZ4/YzIse9WXI4BravaIkR+oO8+tQjbz0rL+uK5zvLviSKe/Txizn4Dyo+M7fSt
 Bi3XlEAQzqeQ1JcX2K09VoCGjGW5X6NWUvQSvyNY2M3JHvVVxPR5LVtGQdGiWmd4p7XyVeH4fKN
 4xfVPiJ
X-Received: by 2002:a05:6a00:198d:b0:827:2eff:a29e with SMTP id
 d2e1a72fcca58-829a2f4b9f0mr9266747b3a.34.1773046640358; 
 Mon, 09 Mar 2026 01:57:20 -0700 (PDT)
X-Received: by 2002:a05:6a00:198d:b0:827:2eff:a29e with SMTP id
 d2e1a72fcca58-829a2f4b9f0mr9266729b3a.34.1773046639928; Mon, 09 Mar 2026
 01:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260304173535.2702587-1-eperezma@redhat.com>
 <20260304173535.2702587-4-eperezma@redhat.com>
In-Reply-To: <20260304173535.2702587-4-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 9 Mar 2026 16:57:08 +0800
X-Gm-Features: AaiRm51k_GotyR8wcRZN15RgpaFMhy1lv2JjTha14ToLeelrn_A9Cr23Gf-4MPk
Message-ID: <CACGkMEsZO1t+-qMaYiuVuWoqbyqb2khoFREHqZ56ZG8hGfojyA@mail.gmail.com>
Subject: Re: [PATCH 3/7] vhost: factor out the descriptor next fetching
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 Dragos Tatulea DE <dtatulea@nvidia.com>, Jonah Palmer <jonah.palmer@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Koushik Dutta <kdutta@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, qemu-stable@nongnu.org,
 Cindy Lu <lulu@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Mar 5, 2026 at 1:35=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat.=
com> wrote:
>
> The next field will not be used if IN_ORDER is enabled.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


