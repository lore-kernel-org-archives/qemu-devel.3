Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B606CA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 18:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xChfu-0002Qy-0B; Fri, 02 Oct 2026 14:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xChfK-0002Ce-6R
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 14:07:36 -0400
Received: from mail-ed2-x10.google.com ([2a00:1450:4864:33::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xChfI-00015X-AT
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 14:07:25 -0400
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a6063d7dc4so308583a12.3
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 11:07:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790964443; cv=none;
 d=google.com; s=arc-20260327;
 b=hAa6O56zY5daKYstU4fcOBsD2Y+9TJPhbRi8Lyb64vBytOjFGvNz28IsG36+7HOUPd
 79sqvm3kLoN8GH/GGJqsr+8zX+x1rNCaXrmx/KqAnFNRFmpQtLNT1TuqweA8adugnt/8
 OiTVdvHQW93cRk0f55yswwUH4KnNqmAfsdxBhSH99PXCZinSNWNYusWfcLDJM6rtV3aF
 fJpRHa3q1K3wUjDHBLSAvZOOXH08PwfIWHQ0kcN8Iir7R3iLHygH6fbz7oJbnqyxeXyy
 8k1rYaM+zsYPjfLt8tnvB1AbLPKVBYxvJVQa7Q2ohq7PKbNtgRX7l+6Oxmga/5U0ACcv
 XiNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6QdMYUD3lRG1Bj9A6I+iBn991Jd0ZSPxjiMHO5cGzhU=;
 fh=WZ/DKXgQCIh3xZLEBR4fX/H1ZM9PKF/y9o2qJfJ3mIo=;
 b=CFjSwAZOGm0rzxIyjQUw2nZXI+C8MxAEqCIfJpAvOsss5qHv2lPVBDkKgDXzo3KIT8
 ts9mpo1I2Gj0ETwQ/kvSPpULmXcyTI++DVonb3uYmdk4Yb1JdDvBfSPaWzN5PRvsENsw
 sR+FPoF9PysvATrfyHbbI1nCTUxJ/Wd2Wf7v+8coG/FTBxzm8Drqlijm7QOWeD4FJiL4
 1JkUqkbgmyrgyBD+fhhgGvoiUZMw3jKhwy6foMDVqeCFtuDzVHDdyLA9RS140UofyuS/
 JGDpNPE5ycQ3yFox2FQYEIFjkApXJiXebkTSCYRDlnqpXiS94gWdOApxS4OxMbypNpdb
 GYaw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790964443; x=1791569243; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6QdMYUD3lRG1Bj9A6I+iBn991Jd0ZSPxjiMHO5cGzhU=;
 b=RTsqA8py81AlAyM/Ey3ZIclm8uPdywPs6pntyg1u+N/yF9YI81kdYYRRBbT9+wjEFF
 YeNkN8AA+vn2LXIXOWUhnABfJJCW3tAhUpitSvI8kmQqNW1DAvG7skSl/xE5R1tx4sRf
 MluPlMK7rWE/dmo8C04Oi/LAUEnQvgkvJ9/ey+hEx41p0k5XuaB2MDhjZ+5/xudxLlcV
 YqSwRXTNY0D/jBY4aEccRpclH8ukTxPZqQwRNApDfSor9II3dbHxxRK4pAnk2mlkY6i4
 UWnrtIA7yXUJj//mbqFsUsYlyg1Y1bYjavARHIIZo4UBbtea0SBQOKnLFnkhRRIe27nx
 S7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790964443; x=1791569243;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6QdMYUD3lRG1Bj9A6I+iBn991Jd0ZSPxjiMHO5cGzhU=;
 b=Kt0r923AmBLCEk4D0mrcntEJWUrGssWSX2ALP/n6pdae2DK0V78s6ExR2jBRICjxgd
 YflT3QwhS1VaNaeJRQrCyZ5uiHgimiubvfIK5JZbBGwfl6bb2rrKIheDVF+nBhSJ/0w7
 zr/M5UNWf4DyU7eBRveMzK6gWQPGbcbKDvrobgebexHixwO3v9mP2aciiSvGeX/xkTJY
 umNlrxYX246ovgp0jczCIC38rZrx74AtH0sexC5D3YHp24s2gsGbatUoI6+o8LAp0vYR
 ru/D5Wy/vN6RR8PD43XlfZIApfbAdbnu1xnV65KxcsemszSsJJqs0GWPbfN34ueDq7rG
 FRlA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzLRn3amk8njEG/qjk9+AqBsjGOuLCtcdZxk8mbj5/1r5AXTr7ebgUqRWwaMeMZTuc5YB4fwBinfdc5@nongnu.org
X-Gm-Message-State: AFq9FYLrBvX4qIkonJ87W0TRG0+wxoSPBRtXtTqQEtnooJNc27mqirhH
 S+HWPJzXHUgjm07xixmMfFZ5v/yxNsn0j/gsv96YRxk1IrkWp/8WKbGHCPmx0wpBIrgnH8A8pkT
 jqodpOwonIl78GC/6Bhg/tV7LTGx0/ni6dbrDVxU=
X-Gm-Gg: AYBFou1XsVs2Lrywkmx+npQMGHULEhB9PYTDWarMqjAQ269SE6kIJHxP9NDdbZrEnmS
 Akg1YA69zPPeou+80FLl/odcakOGX+dqZinDeoao0j+GWU3M5OznWP+gvYGFO0I+KUstH54cdNd
 r13RTt+fRZZtwOnmW5uSbDAJ97qBqhk6Y5f5KzZz6icM9iWDoJOQZNTGJULoYdco3wC+67fKqj3
 uZFmjr7aiBar8nuVKDJh+/3Rh+7FqVJZn33QIl7Lyzp+F31vXS+9+p7fl2VRnfHbnU1I2A5xeeq
 1FCFCntgh3VOEZlmOVDBt8zssWVMqSM48/RTff57mEYkzBeV2eMsyeUKXnEM+TzmUP4=
X-Received: by 2002:a05:6402:24ce:b0:6aa:734b:1a28 with SMTP id
 4fb4d7f45d1cf-6af9e2ecaedmr1899769a12.34.1790964442424; Fri, 02 Oct 2026
 11:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
 <20261001-rv-dedup-v1-7-ea69b07afd31@rev.ng>
 <CAE2XoE_ag1RR_JFwgcg+9zPed+qpO2skf7W1_kiqvwB=Vf9aAQ@mail.gmail.com>
 <f8f27bc3-83ce-4ccf-ae38-a43188b2ebc5@oss.qualcomm.com>
 <ar_AzEWpF9XDGNdg@hive.localdomain>
In-Reply-To: <ar_AzEWpF9XDGNdg@hive.localdomain>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Sat, 3 Oct 2026 02:07:08 +0800
X-Gm-Features: AclHuK8jeeqrBIeLEQk0WzZH3UqzYofOSJR5_ayEbariFLjWbJZZyb52zf4nZho
Message-ID: <CAE2XoE_vsVDXH2qggECnqHC8dMpo7zyTTg9w64uvjnPeXE9y6A@mail.gmail.com>
Subject: Re: [PATCH 07/18] target/riscv: Runtime register MAX and BARE CPUs
To: Anton Johansson <anjo@rev.ng>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com, 
 philmd@oss.qualcomm.com, palmer@dabbelt.com, alistair.francis@wdc.com
Content-Type: multipart/mixed; boundary="00000000000065b75f065cdf67bc"
Received-SPF: pass client-ip=2a00:1450:4864:33::10;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--00000000000065b75f065cdf67bc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

target/riscv: resolve target-dependent CPU definition fields

The class-base initializer later reads def->misa_mxl_max and passes
def->cfg to riscv_cpu_cfg_merge(), which merges max_satp_mode. Resolve
both chooser results in a mutable copy so those steps use the selected
values without modifying the const TypeInfo class data.


defer riscv_cpu_validate_misa_mxl is not enough, mainly
def->misa_mxl_max is accessed in
riscv_cpu_class_base_init, for exactly match previous behavior, add
two callback for each value

On Fri, Oct 2, 2026 at 11:36=E2=80=AFPM Anton Johansson <anjo@rev.ng> wrote=
:
>
> On 02/10/26, Pierrick Bouvier wrote:
> > On 10/1/2026 9:28 AM, Yonggang Luo wrote:
> > > On Thu, Oct 1, 2026 at 11:55=E2=80=AFPM Anton Johansson via qemu deve=
lopment
> > > <qemu-devel@nongnu.org> wrote:
> > >>
> > >> Moves initialization of satp and mxl fields to a class initializatio=
n
> > >> function that checks target_riscv64().
> > >>
> > >> Note: I'm aware the current iteration of this patch is rather hacky,=
 I
> > >> don't like the introduction of runtime_misa_mxl_max, but I'm keeping
> > >> this in to get the series out there and collect feedback.
> > >>
> > >> Signed-off-by: Anton Johansson <anjo@rev.ng>
> > >> ---
> > >>  target/riscv/cpu.h |  1 +
> > >>  target/riscv/cpu.c | 90 +++++++++++++++++++++++++++++++++++--------=
-----------
> > >>  2 files changed, 59 insertions(+), 32 deletions(-)
> > >>
> > >
> > > This patch is how I handle these, just for reference, not a review.
> >
> > Yonggang approach looks cleaner, I would favor this one.
>
> I'm personally not a huge fan, it still feels rather hacky. Why add a
> completely new RISCVCPUDef::target_init just to make sure fields are
> initialized before riscv_cpu_validate_misa_mxl()? Wouldn't moving the
> check to a later point, maybe .instance_init, be better? Then for
> riscv_cpu_init() we get
>
>   riscv_cpu_validate_misa_mxl(mcc);
>   env->misa_mxl =3D mcc->def->misa_mxl_max;
>
> misa_mxl_max would be verified only during instance rather than
> class initialization, which seems like a decent tradeoff for a simpler
> solution.
>
> --
> Anton Johansson
> rev.ng Labs Srl.



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000065b75f065cdf67bc
Content-Type: text/plain; charset="US-ASCII"; 
	name="0001-target-riscv-resolve-target-dependent-CPU-definition.patch"
Content-Disposition: attachment; 
	filename="0001-target-riscv-resolve-target-dependent-CPU-definition.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mur9xek10>
X-Attachment-Id: f_mur9xek10

RnJvbSAzMTEzODg5MmZlNWNmODc4ZGE5ODE4Y2Y5MzUzNWNlMTBiMTI1Y2IwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZb25nZ2FuZyBMdW8gPGx1b3lvbmdnYW5nQGdtYWlsLmNvbT4K
RGF0ZTogU2F0LCAzIE9jdCAyMDI2IDAxOjU0OjUyICswODAwClN1YmplY3Q6IFtQQVRDSF0gdGFy
Z2V0L3Jpc2N2OiByZXNvbHZlIHRhcmdldC1kZXBlbmRlbnQgQ1BVIGRlZmluaXRpb24gZmllbGRz
CgpUaGUgY2xhc3MtYmFzZSBpbml0aWFsaXplciBsYXRlciByZWFkcyBkZWYtPm1pc2FfbXhsX21h
eCBhbmQgcGFzc2VzCmRlZi0+Y2ZnIHRvIHJpc2N2X2NwdV9jZmdfbWVyZ2UoKSwgd2hpY2ggbWVy
Z2VzIG1heF9zYXRwX21vZGUuIFJlc29sdmUKYm90aCBjaG9vc2VyIHJlc3VsdHMgaW4gYSBtdXRh
YmxlIGNvcHkgc28gdGhvc2Ugc3RlcHMgdXNlIHRoZSBzZWxlY3RlZAp2YWx1ZXMgd2l0aG91dCBt
b2RpZnlpbmcgdGhlIGNvbnN0IFR5cGVJbmZvIGNsYXNzIGRhdGEuCgpTaWduZWQtb2ZmLWJ5OiBZ
b25nZ2FuZyBMdW8gPGx1b3lvbmdnYW5nQGdtYWlsLmNvbT4KLS0tCiB0YXJnZXQvcmlzY3YvY3B1
LmMgfCA0MCArKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tCiB0YXJnZXQv
cmlzY3YvY3B1LmggfCAgMiArKwogMiBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCAx
MyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvY3B1LmMgYi90YXJnZXQv
cmlzY3YvY3B1LmMKaW5kZXggYzZmMTczOTA3NS4uNzU0ZjE1ODI1MCAxMDA2NDQKLS0tIGEvdGFy
Z2V0L3Jpc2N2L2NwdS5jCisrKyBiL3RhcmdldC9yaXNjdi9jcHUuYwpAQCAtMzA5Miw2ICszMDky
LDggQEAgc3RhdGljIHZvaWQgcmlzY3ZfY3B1X2NsYXNzX2Jhc2VfaW5pdChPYmplY3RDbGFzcyAq
YywgY29uc3Qgdm9pZCAqZGF0YSkKIAogICAgIGlmIChwY2MtPmRlZikgewogICAgICAgICBtY2Mt
PmRlZiA9IGdfbWVtZHVwMihwY2MtPmRlZiwgc2l6ZW9mKCpwY2MtPmRlZikpOworICAgICAgICBt
Y2MtPmRlZi0+bWF4X3NhdHBfbW9kZV9jaG9vc2UgPSBOVUxMOworICAgICAgICBtY2MtPmRlZi0+
bWlzYV9teGxfbWF4X2Nob29zZSA9IE5VTEw7CiAgICAgfSBlbHNlIHsKICAgICAgICAgbWNjLT5k
ZWYgPSBnX25ldzAoUklTQ1ZDUFVEZWYsIDEpOwogICAgIH0KQEAgLTMxMDgsNyArMzExMCwxNiBA
QCBzdGF0aWMgdm9pZCByaXNjdl9jcHVfY2xhc3NfYmFzZV9pbml0KE9iamVjdENsYXNzICpjLCBj
b25zdCB2b2lkICpkYXRhKQogI2VuZGlmCiAKICAgICBpZiAoZGF0YSkgewotICAgICAgICBjb25z
dCBSSVNDVkNQVURlZiAqZGVmID0gZGF0YTsKKyAgICAgICAgUklTQ1ZDUFVEZWYgZGVmX2RhdGEg
PSAqKGNvbnN0IFJJU0NWQ1BVRGVmICopZGF0YTsKKyAgICAgICAgUklTQ1ZDUFVEZWYgKmRlZiA9
ICZkZWZfZGF0YTsKKworICAgICAgICBpZiAoZGVmLT5tYXhfc2F0cF9tb2RlX2Nob29zZSkgewor
ICAgICAgICAgICAgZGVmLT5jZmcubWF4X3NhdHBfbW9kZSA9IGRlZi0+bWF4X3NhdHBfbW9kZV9j
aG9vc2UoZGVmKTsKKyAgICAgICAgfQorICAgICAgICBpZiAoZGVmLT5taXNhX214bF9tYXhfY2hv
b3NlKSB7CisgICAgICAgICAgICBkZWYtPm1pc2FfbXhsX21heCA9IGRlZi0+bWlzYV9teGxfbWF4
X2Nob29zZShkZWYpOworICAgICAgICB9CisKICAgICAgICAgbWNjLT5kZWYtPmJhcmUgfD0gZGVm
LT5iYXJlOwogICAgICAgICBpZiAoZGVmLT5wcm9maWxlKSB7CiAgICAgICAgICAgICBhc3NlcnQo
cHJvZmlsZV9leHRlbmRzKGRlZi0+cHJvZmlsZSwgbWNjLT5kZWYtPnByb2ZpbGUpKTsKQEAgLTMy
OTksNiArMzMxMCwxOCBAQCBzdGF0aWMgdm9pZCByaXNjdl9jcHVfaW5zdGFuY2VfZmluYWxpemUo
T2JqZWN0ICpvYmopCiAgICAgZ19jbGVhcl9wb2ludGVyKCZjcHUtPm11bHRpX2V4dF91c2VyX29w
dHMsIGdfaGFzaF90YWJsZV9kZXN0cm95KTsKIH0KIAorc3RhdGljIGludDhfdCByaXNjdl9jcHVf
bWF4X3NhdHBfbW9kZV9jaG9vc2UoY29uc3QgUklTQ1ZDUFVEZWYgKmRlZikKK3sKKyAgICAodm9p
ZClkZWY7CisgICAgcmV0dXJuIHRhcmdldF9yaXNjdjMyKCkgPyBWTV8xXzEwX1NWMzIgOiBWTV8x
XzEwX1NWNTc7Cit9CisKK3N0YXRpYyBSSVNDVk1YTCByaXNjdl9jcHVfbWlzYV9teGxfbWF4X2No
b29zZShjb25zdCBSSVNDVkNQVURlZiAqZGVmKQoreworICAgICh2b2lkKWRlZjsKKyAgICByZXR1
cm4gdGFyZ2V0X3Jpc2N2MzIoKSA/IE1YTF9SVjMyIDogTVhMX1JWNjQ7Cit9CisKIHN0YXRpYyBj
b25zdCBUeXBlSW5mbyByaXNjdl9jcHVfdHlwZV9pbmZvc1tdID0gewogICAgIHsKICAgICAgICAg
Lm5hbWUgPSBUWVBFX1JJU0NWX0NQVSwKQEAgLTMzMzksMjEgKzMzNjIsMTIgQEAgc3RhdGljIGNv
bnN0IFR5cGVJbmZvIHJpc2N2X2NwdV90eXBlX2luZm9zW10gPSB7CiAgICAgICAgICAqIG9ubHkg
TUJBUkUgd2lsbCBiZSBhdmFpbGFibGUgaWYgdGhlIHVzZXIgZG9lc24ndCBlbmFibGUKICAgICAg
ICAgICogYSBtb2RlIG1hbnVhbGx5IChzZWUgcmlzY3ZfY3B1X3NhdHBfbW9kZV9maW5hbGl6ZSgp
KS4KICAgICAgICAgICovCi0jaWZkZWYgVEFSR0VUX1JJU0NWMzIKLSAgICAgICAgLmNmZy5tYXhf
c2F0cF9tb2RlID0gVk1fMV8xMF9TVjMyLAotI2Vsc2UKLSAgICAgICAgLmNmZy5tYXhfc2F0cF9t
b2RlID0gVk1fMV8xMF9TVjU3LAotI2VuZGlmCisgICAgICAgIC5tYXhfc2F0cF9tb2RlX2Nob29z
ZSA9IHJpc2N2X2NwdV9tYXhfc2F0cF9tb2RlX2Nob29zZSwKICAgICApLAogCiAgICAgREVGSU5F
X1JJU0NWX0NQVShUWVBFX1JJU0NWX0NQVV9NQVgsIFRZUEVfUklTQ1ZfRFlOQU1JQ19DUFUsCi0j
aWYgZGVmaW5lZChUQVJHRVRfUklTQ1YzMikKLSAgICAgICAgLm1pc2FfbXhsX21heCA9IE1YTF9S
VjMyLAotICAgICAgICAuY2ZnLm1heF9zYXRwX21vZGUgPSBWTV8xXzEwX1NWMzIsCi0jZWxpZiBk
ZWZpbmVkKFRBUkdFVF9SSVNDVjY0KQotICAgICAgICAubWlzYV9teGxfbWF4ID0gTVhMX1JWNjQs
Ci0gICAgICAgIC5jZmcubWF4X3NhdHBfbW9kZSA9IFZNXzFfMTBfU1Y1NywKLSNlbmRpZgorICAg
ICAgICAubWF4X3NhdHBfbW9kZV9jaG9vc2UgPSByaXNjdl9jcHVfbWF4X3NhdHBfbW9kZV9jaG9v
c2UsCisgICAgICAgIC5taXNhX214bF9tYXhfY2hvb3NlID0gcmlzY3ZfY3B1X21pc2FfbXhsX21h
eF9jaG9vc2UsCiAgICAgKSwKIAogICAgIERFRklORV9BQlNUUkFDVF9SSVNDVl9DUFUoVFlQRV9S
SVNDVl9DUFVfU0lGSVZFX0UsIFRZUEVfUklTQ1ZfVkVORE9SX0NQVSwKZGlmZiAtLWdpdCBhL3Rh
cmdldC9yaXNjdi9jcHUuaCBiL3RhcmdldC9yaXNjdi9jcHUuaAppbmRleCAwMzRkN2U5NmM0Li5i
NmI1ZjY3OWM5IDEwMDY0NAotLS0gYS90YXJnZXQvcmlzY3YvY3B1LmgKKysrIGIvdGFyZ2V0L3Jp
c2N2L2NwdS5oCkBAIC01OTcsNiArNTk3LDggQEAgdHlwZWRlZiBzdHJ1Y3QgUklTQ1ZDUFVEZWYg
ewogI2VuZGlmCiAgICAgLyogVGhpcyBpcyBqdXN0IGEgc2V0dGVyIGZvciBlbnYtPm51bV90cmln
Z2Vycy4gICovCiAgICAgdWludDMyX3QgbnVtX3RyaWdnZXJzOworICAgIGludDhfdCAoKm1heF9z
YXRwX21vZGVfY2hvb3NlKShjb25zdCBzdHJ1Y3QgUklTQ1ZDUFVEZWYgKmRlZik7CisgICAgUklT
Q1ZNWEwgKCptaXNhX214bF9tYXhfY2hvb3NlKShjb25zdCBzdHJ1Y3QgUklTQ1ZDUFVEZWYgKmRl
Zik7CiB9IFJJU0NWQ1BVRGVmOwogCiAvKioKLS0gCjIuNTUuMC53aW5kb3dzLjMKCg==
--00000000000065b75f065cdf67bc--

