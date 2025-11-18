Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFA2CEBF92
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 08:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLHJZ-00081a-OV; Tue, 18 Nov 2025 03:43:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLHJX-00080H-9b
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 03:43:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLHJU-0001C9-UY
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 03:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763455424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sey3LaydkzTf6bfn/6aPShMse5wB+Y/jN+PUnhD1ymc=;
 b=fbgDoTvw0DS+MbfG/+2S/jw/O+IyVU1lSAUahazKKwcZ/iPnjZndx5gRtdykdNcVF4P7K3
 300Kod+ckH/bASacCS3ZV40sGvf4ettVbg7ewTwJrCphFdzT47T/WpGWRdbi+5ysdgM1KV
 oVCdVhEGFfndZnXNf5Uy6QVMGZYeSSw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-QlSdhdwkMy67k7P5XIDc-g-1; Tue, 18 Nov 2025 03:43:42 -0500
X-MC-Unique: QlSdhdwkMy67k7P5XIDc-g-1
X-Mimecast-MFC-AGG-ID: QlSdhdwkMy67k7P5XIDc-g_1763455421
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47754e6bddbso36249315e9.3
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 00:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763455419; x=1764060219; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sey3LaydkzTf6bfn/6aPShMse5wB+Y/jN+PUnhD1ymc=;
 b=ZkuhSMZiSVo4+/aETXn/VrABIKAlfMBNT2p5tC/hKtHX7G/aizHKs9Dk4qtkc8Te5H
 JVm7DstDCkxneyPWb1ga4ZeUjRpWRkjXUMJquZgio4Q5gJF+bHqEHEmHlfF7Xrv4we8V
 szl28nlC9qh4AfGzkkg3UizeNa0CzjdvcNyBCpPWRWaWRSGXCCmKIbNB1l9suqICWp/e
 kMj3/jYN1qkwpApINkIOSRgImyELVoXYuYt+uhCfHoH9XVG5cgcVIxQVnr2tekNyQm02
 Bdzros/czCTZXmyzFJU7N+Q58/QxzILRDvjGEung8t67OcIyWaNXHnJS5gsCEIQ1TkpX
 qNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763455419; x=1764060219;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sey3LaydkzTf6bfn/6aPShMse5wB+Y/jN+PUnhD1ymc=;
 b=qOroZFwCWXq03IDd18bQnRht1JH6xQlJtk/udL2n3cXkk+N1AlFUqDi3412DCbcQdR
 fgq2gEK+Sdtj8zZ3/CAPAcmB0v1eNHXTYlXHhwGE+adu6wXBnfAFw13y+U62Lm42mw68
 6q4Ammi8nx6nIKcotZ9j4bm7IyNW+Yy3IOPCmDIXdWbSULfLuYrQcXjS4LzTVR/5rksc
 ZdmpWXJXt+kaApUk4jBlKHYEYpQehIbDrkjE14sg4FwFLwx7n7JmWTaVgBF7m10NlUfw
 Zp1TWOWscTayf7sLCfvT5ox+HVe7peBUokcM48zJcqko2Z74t83XHVaYXDnJQt7E7odY
 fdLw==
X-Gm-Message-State: AOJu0Ywfo7tYjuYYKv6uutGpTBx0dYn00sc4A2YAnGI9Z9F+Qv0VfzOj
 AorPhW2eUiF8pfH6DAcND/qES0DY0J/GFRxCSzfU9+m7DsICz+X9meYneHY/hJgYfB4mNjeRAea
 zW71BGjrg257PuGdwuHiI5Tdft0tewpYRoBWBTFAaAAMqWsbre0X1V3lkRw1uyKxH6mRIqGdYAF
 Mte0nwqAnBDlUysHdLGPDQjhpotCQs/uyrFjybt+59mQ==
X-Gm-Gg: ASbGncsXFdFyvcHRs797SWWogOFtoyVHjL13eiQ7KKhoTg34qDQEnpCPsckSbRqq0c+
 cpx9DVCsQjpUb3cJkNJwGfxaj5eTW51z2fxqLXtwe5kssU886s6dWAV41gowCGxaINVYfDDZeYs
 Vet/gd6acxcUUJCbK/HsFIS7tri3KTXlm+8Q693dzi2qsHFD3FLpGJLKuUDlK7ztdu1RfeFeTsH
 kJmkC3J2OG0TuysFXiwhdyrYjonnGWbuWl5+zrVw2gUCQY0vDYdrrA1RyGtSaCEWhv7ZDM=
X-Received: by 2002:a05:600c:4f93:b0:477:7479:f081 with SMTP id
 5b1f17b1804b1-4778fe67b9amr141087415e9.12.1763455419524; 
 Tue, 18 Nov 2025 00:43:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNBeIEFUifGZtItCnp4Klj90vHm0zqLHTOjjICuFkx6TVlr/3YLnlQtLS0OCEOpq2uJG9A+MNK6li2TJtdV0E=
X-Received: by 2002:a05:600c:4f93:b0:477:7479:f081 with SMTP id
 5b1f17b1804b1-4778fe67b9amr141087045e9.12.1763455419054; Tue, 18 Nov 2025
 00:43:39 -0800 (PST)
MIME-Version: 1.0
References: <20251118065817.835017-1-zhao1.liu@intel.com>
 <20251118065817.835017-3-zhao1.liu@intel.com>
In-Reply-To: <20251118065817.835017-3-zhao1.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Nov 2025 09:43:26 +0100
X-Gm-Features: AWmQ_bl3d1pDweky_dSebvm7DCwRxpOkVncewHuoqCnovK36jQkzTfCwBZJBgys
Message-ID: <CABgObfbzzwCafmGehgzCC-pFSnRR1OW_wfQxR4OJDAbv4mCztQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] i386/cpu: Cache EGPRs in CPUX86State
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 "Chang S . Bae" <chang.seok.bae@intel.com>, Zide Chen <zide.chen@intel.com>, 
 Xudong Hao <xudong.hao@intel.com>
Content-Type: multipart/mixed; boundary="000000000000d4b8f00643da7552"
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

--000000000000d4b8f00643da7552
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 7:43=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
>
> From: Zide Chen <zide.chen@intel.com>
>
> Cache EGPR[16] in CPUX86State to store APX's EGPR value.

Please change regs[] to have 32 elements instead; see the attached
patch for a minimal starting point. You can use VMSTATE_SUB_ARRAY to
split their migration data in two parts. You'll have to create a
VMSTATE_UINTTL_SUB_ARRAY similar to VMSTATE_UINT64_SUB_ARRAY.

To support HMP you need to adjust target/i386/monitor.c and
target/i386/cpu-dump.c. Please make x86_cpu_dump_state print R16...R31
only if APX is enabled in CPUID.

Also, it would be best for the series to include gdb support. APX is
supported by gdb as a "coprocessor", the easiest way to do it is to
copy what riscv_cpu_register_gdb_regs_for_features() does for the FPU,
and copy https://github.com/intel/gdb/blob/master/gdb/features/i386/64bit-a=
px.xml
into QEMU's gdb-xml/ directory.

Paolo

> Tested-by: Xudong Hao <xudong.hao@intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  target/i386/cpu.h          |  1 +
>  target/i386/xsave_helper.c | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index bc7e16d6e6c1..48d4d7fcbb9c 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1969,6 +1969,7 @@ typedef struct CPUArchState {
>  #ifdef TARGET_X86_64
>      uint8_t xtilecfg[64];
>      uint8_t xtiledata[8192];
> +    uint64_t egprs[EGPR_NUM];
>  #endif
>
>      /* sysenter registers */
> diff --git a/target/i386/xsave_helper.c b/target/i386/xsave_helper.c
> index 996e9f3bfef5..2e9265045520 100644
> --- a/target/i386/xsave_helper.c
> +++ b/target/i386/xsave_helper.c
> @@ -140,6 +140,13 @@ void x86_cpu_xsave_all_areas(X86CPU *cpu, void *buf,=
 uint32_t buflen)
>
>          memcpy(tiledata, &env->xtiledata, sizeof(env->xtiledata));
>      }
> +
> +    e =3D &x86_ext_save_areas[XSTATE_APX_BIT];
> +    if (e->size && e->offset && buflen) {
> +        XSaveAPX *apx =3D buf + e->offset;
> +
> +        memcpy(apx, &env->egprs, sizeof(env->egprs));
> +    }
>  #endif
>  }
>
> @@ -275,5 +282,12 @@ void x86_cpu_xrstor_all_areas(X86CPU *cpu, const voi=
d *buf, uint32_t buflen)
>
>          memcpy(&env->xtiledata, tiledata, sizeof(env->xtiledata));
>      }
> +
> +    e =3D &x86_ext_save_areas[XSTATE_APX_BIT];
> +    if (e->size && e->offset) {
> +        const XSaveAPX *apx =3D buf + e->offset;
> +
> +        memcpy(&env->egprs, apx, sizeof(env->egprs));
> +    }
>  #endif
>  }
> --
> 2.34.1
>

--000000000000d4b8f00643da7552
Content-Type: text/x-patch; charset="US-ASCII"; name="f.patch"
Content-Disposition: attachment; filename="f.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mi4bn3520>
X-Attachment-Id: f_mi4bn3520

ZGlmZiAtLWdpdCBhL3RhcmdldC9pMzg2L2NwdS5oIGIvdGFyZ2V0L2kzODYvY3B1LmgKaW5kZXgg
Y2VlMWY2OTJhMWMuLjA4MTZmMWRkMjJmIDEwMDY0NAotLS0gYS90YXJnZXQvaTM4Ni9jcHUuaAor
KysgYi90YXJnZXQvaTM4Ni9jcHUuaApAQCAtMTYzOCwxMiArMTYzOCwxNSBAQCB0eXBlZGVmIHN0
cnVjdCB7CiAgICAgdWludDY0X3QgbWFzazsKIH0gTVRSUlZhcjsKIAorI2RlZmluZSBDUFVfTkJf
RVJFR1M2NCAzMgogI2RlZmluZSBDUFVfTkJfUkVHUzY0IDE2CiAjZGVmaW5lIENQVV9OQl9SRUdT
MzIgOAogCiAjaWZkZWYgVEFSR0VUX1g4Nl82NAorI2RlZmluZSBDUFVfTkJfRVJFR1MgQ1BVX05C
X0VSRUdTNjQKICNkZWZpbmUgQ1BVX05CX1JFR1MgQ1BVX05CX1JFR1M2NAogI2Vsc2UKKyNkZWZp
bmUgQ1BVX05CX0VSRUdTIENQVV9OQl9SRUdTMzIKICNkZWZpbmUgQ1BVX05CX1JFR1MgQ1BVX05C
X1JFR1MzMgogI2VuZGlmCiAKQEAgLTE4NDUsNyArMTg0OCw3IEBAIHR5cGVkZWYgc3RydWN0IENQ
VUNhY2hlcyB7CiAKIHR5cGVkZWYgc3RydWN0IENQVUFyY2hTdGF0ZSB7CiAgICAgLyogc3RhbmRh
cmQgcmVnaXN0ZXJzICovCi0gICAgdGFyZ2V0X3Vsb25nIHJlZ3NbQ1BVX05CX1JFR1NdOworICAg
IHRhcmdldF91bG9uZyByZWdzW0NQVV9OQl9FUkVHU107CiAgICAgdGFyZ2V0X3Vsb25nIGVpcDsK
ICAgICB0YXJnZXRfdWxvbmcgZWZsYWdzOyAvKiBlZmxhZ3MgcmVnaXN0ZXIuIER1cmluZyBDUFUg
ZW11bGF0aW9uLCBDQwogICAgICAgICAgICAgICAgICAgICAgICAgZmxhZ3MgYW5kIERGIGFyZSBz
ZXQgdG8gemVybyBiZWNhdXNlIHRoZXkgYXJlCkBAIC0xOTAyLDcgKzE5MDUsNyBAQCB0eXBlZGVm
IHN0cnVjdCBDUFVBcmNoU3RhdGUgewogICAgIGZsb2F0X3N0YXR1cyBtbXhfc3RhdHVzOyAvKiBm
b3IgM0ROb3chIGZsb2F0IG9wcyAqLwogICAgIGZsb2F0X3N0YXR1cyBzc2Vfc3RhdHVzOwogICAg
IHVpbnQzMl90IG14Y3NyOwotICAgIFpNTVJlZyB4bW1fcmVnc1tDUFVfTkJfUkVHUyA9PSA4ID8g
OCA6IDMyXSBRRU1VX0FMSUdORUQoMTYpOworICAgIFpNTVJlZyB4bW1fcmVnc1tDUFVfTkJfRVJF
R1NdIFFFTVVfQUxJR05FRCgxNik7CiAgICAgWk1NUmVnIHhtbV90MCBRRU1VX0FMSUdORUQoMTYp
OwogICAgIE1NWFJlZyBtbXhfdDA7CiAKZGlmZiAtLWdpdCBhL3RhcmdldC9pMzg2L2dkYnN0dWIu
YyBiL3RhcmdldC9pMzg2L2dkYnN0dWIuYwppbmRleCAwNGM0OWU4MDJkNy4uMTdkOGUzNTA4MzQg
MTAwNjQ0Ci0tLSBhL3RhcmdldC9pMzg2L2dkYnN0dWIuYworKysgYi90YXJnZXQvaTM4Ni9nZGJz
dHViLmMKQEAgLTEyNSw2ICsxMjUsNyBAQCBpbnQgeDg2X2NwdV9nZGJfcmVhZF9yZWdpc3RlcihD
UFVTdGF0ZSAqY3MsIEdCeXRlQXJyYXkgKm1lbV9idWYsIGludCBuKQogICAgICAgIG9mIGEgc2Vz
c2lvbi4gU28gaWYgd2UncmUgaW4gMzItYml0IG1vZGUgb24gYSA2NC1iaXQgY3B1LCBzdGlsbCBh
Y3QKICAgICAgICBhcyBpZiB3ZSdyZSBvbiBhIDY0LWJpdCBjcHUuICovCiAKKyAgICAvLyBUT0RP
OiBBUFggcmVnaXN0ZXJzCiAgICAgaWYgKG4gPCBDUFVfTkJfUkVHUykgewogICAgICAgICBpZiAo
VEFSR0VUX0xPTkdfQklUUyA9PSA2NCkgewogICAgICAgICAgICAgaWYgKGVudi0+aGZsYWdzICYg
SEZfQ1M2NF9NQVNLKSB7Cg==
--000000000000d4b8f00643da7552--


