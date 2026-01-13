Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9A5D29DE0
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 07:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfYiz-0002cG-6t; Tue, 13 Jan 2026 02:21:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfYip-0002NV-F9
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 02:21:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfYim-0005nI-SN
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 02:21:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768288904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DIyBP1UlbfdGj0aq90i6iUmp48Wa3gdQSlmSZC+cYDk=;
 b=g3A7PjKOAiCNK+FRP+NimMwldzmjBu4Wmsr8Axf2Dq1D5OKGOmSe69N41fI8jjkKXrhrLM
 hT2FGBipxGsfmWVjDA5LnPCIW3S7/cR9d0nU7FQpTX3kG2gw2ZjCJnxr3VIgLspS5sPhTr
 nnw9WbiZHb9KKYbgaoxSri7+MCaPDek=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-W-VDnY5rNK2rpXjAM4mhvw-1; Tue, 13 Jan 2026 02:21:40 -0500
X-MC-Unique: W-VDnY5rNK2rpXjAM4mhvw-1
X-Mimecast-MFC-AGG-ID: W-VDnY5rNK2rpXjAM4mhvw_1768288900
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c552bbd1b03so1916150a12.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 23:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768288900; x=1768893700; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DIyBP1UlbfdGj0aq90i6iUmp48Wa3gdQSlmSZC+cYDk=;
 b=oyjBkgfpEUxV9xp7cGPvNY1Au0XYorkrM51vP6Lcde+ZYHVOsZHt99ccso5tSR/dt7
 dRRLQZusUy4Og57m+bxp/r+7do0z+x3cPIQ7GZ+oMa8tHtYY+m6YEzKUhBNVJ0qwO019
 JLG5nYn7d7eY9KcEyiK6nogdUfn2De1lpYAjFf5BGj0Z+Ts/PbfQxbdLfDat4U2MPqfb
 aqSPiC+bTmYdOAKbuirGkvhy/QD2epT9DbIBu6mk7h8+d4hqO+lhVx3kA8jko6qSJTn2
 fRIVGmllXGKrsnSBkJlXf1QFcygthPFQF3xYIT1z26A3nBUh9T4khcYIbQHGOGnulQ9q
 rGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768288900; x=1768893700;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DIyBP1UlbfdGj0aq90i6iUmp48Wa3gdQSlmSZC+cYDk=;
 b=FKmEhIhIuwpf3NFzFtEed3Uq5pMZDk/Ia0KUR9mjuYowSSZHvyyXk373IB0+3Zz4QJ
 5w0NVE907ydeosuMzv97jIbeUuy83vg+sX4NFsLUTXwFznWnOQQ0fosgdFFx4U/g7W/R
 nXKlx8gJIIA7eNr26onjhC+y59U4rsBX8fUZlQCVI/IrzKoyiBBx57U25f2GuHjEm1xa
 +WhreTRY/oiPuKI9vshmvwrS1vKuyhZLjhi8FOoPRlR74HdULwMxC6D6rXm+uDN5r/he
 IIOYSXUaOI8AGZuOuIrwdVGA/C6AJuGzhBneV+h+EiTTrC1KWCkgqX2NzmbVJIkFYdF6
 PFKQ==
X-Gm-Message-State: AOJu0YwqHJySlpwtmSU4lWWIHu5cQqVHDtgWhvqu3ucJRPUXKuvXJqr9
 ic3NqMiV/MdQUl12ydDAnDpBDeEjtmvD+u0Ef+comogZx6JirqHOnfZsVZ3cv3uY1zF9QihDm/J
 Y9ByuCRKRc+adjIOw4SouaDXulHvX3DbIaW2H0s3Nb2eHl2itTsmwZIuO
X-Gm-Gg: AY/fxX6GmP/3d088lKHKZFp21oypVgBXqyOgGXVMJJA6XtNhmSsIy50oMfX92rbIIlP
 rGb5wd/syxCYrl5Nxh3XXH7UPaD04CGw+waYInsOXU76hCu+l9KP/wZYpBR8K0w6lQJZ5IBaB4Z
 F7jrg6tlHiE26QRWV3ePuByieZj9GdlY4i2odC0/pEhh4P7/bQkzR1Ivev+ZEJapUM6cS1hb7uY
 dnnx8kmqW2Cv09mEsNOdNWlE+cIqCzbGto2tl/RcTtWjtDxb1VFCTos2GaSUc/21zuOQiq0QF9Z
 wh0+ADzWRstlwvjNzI4R80LBBRZN80/6lNxSLswzw4AJ2SR5Aao8H+XpS9+dVPkCyeZp4RSZH5a
 JXbAALoi6wWcKCr+BwHkfR6HjZ32DKGpLPJbbXyjN/c24HVmvJTKa76ch+g==
X-Received: by 2002:a05:6300:218a:b0:363:e391:38a2 with SMTP id
 adf61e73a8af0-3898f992b67mr20813680637.46.1768288899865; 
 Mon, 12 Jan 2026 23:21:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnXXHOaNZdnaiFJjLFVPw/Sw4deHVWC+/H1ql2dN49b4/t9y4V96E08v4qiFAQ/eHCtN/hlQ==
X-Received: by 2002:a05:6300:218a:b0:363:e391:38a2 with SMTP id
 adf61e73a8af0-3898f992b67mr20813646637.46.1768288899479; 
 Mon, 12 Jan 2026 23:21:39 -0800 (PST)
Received: from smtpclient.apple ([110.227.88.119])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5f8c45b6sm19101810a91.17.2026.01.12.23.21.35
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Jan 2026 23:21:39 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH v3 3/6] igvm: Add missing NULL check
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20260109143413.293593-4-osteffen@redhat.com>
Date: Tue, 13 Jan 2026 12:51:23 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Joerg Roedel <joerg.roedel@amd.com>, Gerd Hoffmann <kraxel@redhat.com>,
 kvm@vger.kernel.org, Eduardo Habkost <eduardo@habkost.net>,
 Michael Tsirkin <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F2E4DEF4-3E69-47E4-946F-8795FD6CF77B@redhat.com>
References: <20260109143413.293593-1-osteffen@redhat.com>
 <20260109143413.293593-4-osteffen@redhat.com>
To: Oliver Steffen <osteffen@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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



> On 9 Jan 2026, at 8:04=E2=80=AFPM, Oliver Steffen =
<osteffen@redhat.com> wrote:
>=20
> Check for NULL pointer returned from igvm_get_buffer().
> Documentation for that function calls for that unconditionally.
>=20
> Signed-off-by: Oliver Steffen <osteffen@redhat.com>
> ---
> backends/igvm.c | 13 ++++++++++---
> 1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/backends/igvm.c b/backends/igvm.c
> index a350c890cc..dc1fd026cb 100644
> --- a/backends/igvm.c
> +++ b/backends/igvm.c
> @@ -170,9 +170,16 @@ static int qigvm_handler(QIgvm *ctx, uint32_t =
type, Error **errp)
>                 (int)header_handle);
>             return -1;
>         }
> -        header_data =3D igvm_get_buffer(ctx->file, header_handle) +
> -                      sizeof(IGVM_VHS_VARIABLE_HEADER);
> -        result =3D handlers[handler].handler(ctx, header_data, errp);
> +        header_data =3D igvm_get_buffer(ctx->file, header_handle);
> +        if (header_data =3D=3D NULL) {
> +            error_setg(
> +                errp,
> +                "IGVM: Failed to get directive header data (code: =
%d)",
> +                (int)header_handle);
> +            result =3D -1;

I would just return -1 here and remove the else {} clause below. It =
makes it slightly easier to follow the code.

> +        } else {
> +            result =3D handlers[handler].handler(ctx, header_data + =
sizeof(IGVM_VHS_VARIABLE_HEADER), errp);
> +        }
>         igvm_free_buffer(ctx->file, header_handle);
>         return result;
>     }
> --=20
> 2.52.0
>=20


