Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D10C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 21:45:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2FEL-0003JK-Qn; Thu, 03 Sep 2026 17:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imaginos32@gmail.com>)
 id 1x2FEK-0003It-2c
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 17:44:20 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imaginos32@gmail.com>)
 id 1x2FEH-0000ft-O9
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 17:44:19 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c25344a8c6cso41467466b.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 14:44:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788471853; cv=none;
 d=google.com; s=arc-20260327;
 b=LTmZ89ANCf8OYuLeYAjPJF/Dq5kHnYyPeYEXOmXzi3CX6RQtmdW+RXaJFQ7iNwdMd8
 T27XxXhh+lLTmEOcwOd+zNzBMKXLIrwWsmspkPRCSmeyEpmc23TxR7RSdZWV9CgAZk0W
 xno+kHF+woIsfg2XDsqt7WVeYTiCj/Oe6f5MfPHJeGx/IkeraNNm7cuQUJuapBCKbYdc
 SjZVB1UHbUmnOvNiDct6/I9SmNWhRCHp3aP+FD06lCfN1lU9imua4Vtj47fwh+DlUhXF
 KNhre9loqsHtDMATUCUFg24gqJ1tJE09fNVgrtIAdeiEcTHFeq6OTKDNXXL/eS5q+tnQ
 KNHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NM/A0Mlkja94yQk6cnLe0eIU3ocmo1zuYO4zAfHXGMI=;
 fh=DgTdLeFZ0bTOCqdmZG8Xw+mJaTlg8TAyzNQ2c4DmOWk=;
 b=Z+NnMmnaxvqhz1q/+dgOCJ8msF2hq6IeMgGlLxsmBqsJG0VHE2+kFPfgZMZfCLvk/Y
 1R+nXdFg19pvcS4usOozdurmq6oHmy1d65PvDfVmpFdnNgkaF+GAev66hqC3753mO4At
 +IfTT098g910o01niOVi8tNBY3YnG74Omhnx6Zd5lEvx2lGUdK0IBfHXzyXKThqlyYwz
 C+9XE2DCx2grVSoRGn/y9kwpY5Jft3JyKXxccCir7MzroeMdnw87CjYZbMrkBEJH18eU
 gl8bdAlLKkd1YO3++vkkmWMDBiNcIbuZOtGkOv0ybb2Zc87yuflDM44Ekcj1i98GWhWw
 vQpQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788471853; x=1789076653; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NM/A0Mlkja94yQk6cnLe0eIU3ocmo1zuYO4zAfHXGMI=;
 b=qCvQToPgz8Vzi/O2hCxP86QDxL9yepekrplT6ezTQEdD/ioM3ej5VMdov6AmVyzXsL
 hc7KP8gxDNQYlgvEPJBB/ZldMq4ql64bmwDQKbrkh8wNPRId0hL/InJnfSU2f6jJso0C
 Bi9D/qd3UpGh7H+eb1iB2MyMxqAUvONH0o+sYG+rgeodqExkNvzOwd8MBbFl5kO3opBF
 JCbu4ppkrS8ijzp5E09KoMQvxaiNp70cFAS4S9q3UmmBdGx5lCSH1c7dJ9GxJq1DazW3
 aUuA60hHg9VTT7Pla8hwvkr/ZV5cBD8wOFAkqJqnMZQambZpZAJwhdlgZJnW2x8S1tYd
 xvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788471853; x=1789076653;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NM/A0Mlkja94yQk6cnLe0eIU3ocmo1zuYO4zAfHXGMI=;
 b=rXkED3viv0z/HeH4p48ZC8R0wOK+PnZgZrJDsoGPbddCl3Zo+KY+9069XbET8vzl/+
 coKBMKUHJNF5pwDek79FRqGqH0PLGtEN9WqOGLHxitRLU8T5r8joqQRyGxblB4yve6pD
 TBCssjxIolZtiulcNzAn9ikFm7yar1nx34cFk+ajFrep50Y7Mv64GLNHUnvk+rA/fyWm
 kAjennY4L48pBGvgkJTqAq8eK+MUNWTuC7XPwYZVRbAQs+Z4a0zlh37ygwToOrC8eC2L
 Q3EvPorscic7aGtu03lkAhTEoojiFqWzrRTIB5z5cXVcyZMWGj5Afb86ZWfTdnlLBImY
 yJYQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByIpjoXL8lyvkmskdG9wqM5edbj4PxV+Nlb3Fswcq95eLT6otAFUbJ4ohan/s5wsqilkh2xiTTLNrvB@nongnu.org
X-Gm-Message-State: AFuF++kPW/LUTEPuIzhdMQcm8Y09ln6jrvV5mwOJMUqv4QMJzXDlHdr2
 e9+VXTfN+eTXc8ZE3xhgPZUjdaHh8SyTOKzRgdlbDD7Ww6dlOmBUr1oPrJcT8snJNv5aEYqZcIz
 ysnGkRY71NPufaGjdRdnf0BCbSKA0pJU=
X-Gm-Gg: AYBFou2s6L0HcCaHGGVKjyo0pXje2qYvP+Phv2Pxa/T9NsP1VzURJPA37yblU7C3I1X
 rbBCuB89LRn3dLIbjc4MMl3sSPuLE90IfBNLyDp6MjdZD2oBAEkHz7VwcIFTnPSaawljkCOXg83
 VTLII9iZuntS9ldiJsf3dgPvSSsaNK2YseVe80VBW/MVHH7DMLf66/9qUQ8j76dTJr7c/rnWPVL
 DH4vIyfTDw6/thLZglpUmfQva33B76rfJsPcpg+0NqTYd4lPPnSx+pRrHf10N+uI+q7rjSMwh96
 781Y3W3Zem2EtBtqxbQXZh6eWgouX88lTe7k4CEBK80=
X-Received: by 2002:a17:907:94c7:b0:c25:8fb2:5e24 with SMTP id
 a640c23a62f3a-c260c99681emr105943066b.15.1788471853400; Thu, 03 Sep 2026
 14:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260705140508.17692-1-imaginos32@gmail.com>
 <8dc3208da0af8ecf733c4dad287090b66bf76fd5.camel@wdc.com>
In-Reply-To: <8dc3208da0af8ecf733c4dad287090b66bf76fd5.camel@wdc.com>
From: Imaginos <imaginos32@gmail.com>
Date: Thu, 3 Sep 2026 23:44:01 +0200
X-Gm-Features: AcwNN1Ue0qtJgID2GoRuHRahK4D3cmu8iYTC6mhOlIsrMvNfJGBWv4vCzNvPCkM
Message-ID: <CAFxqGk9bAPvOZLq4s76SuMyETcz8OjqQDw7oUw6Akq1HccRvBQ@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: check G-stage write permission for
 VS-stage A/D updates
To: Alistair Francis <Alistair.Francis@wdc.com>
Cc: "palmer@dabbelt.com" <palmer@dabbelt.com>, 
 "chao.liu.zevorn@gmail.com" <chao.liu.zevorn@gmail.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, 
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="0000000000008347c2065a9b0d6c"
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=imaginos32@gmail.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000008347c2065a9b0d6c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just following up to ping the patch again

=D0=BF=D0=B5=D1=82, 10. =D1=98=D1=83=D0=BB 2026. =D1=83 04:23 Alistair Fran=
cis <Alistair.Francis@wdc.com> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:

> On Sun, 2026-07-05 at 16:02 +0200, imaginos wrote:
> > During a two-stage (VS-stage + G-stage) page-table walk with hardware
> > A/D updating enabled (Svadu / menvcfg.ADUE), a store that reaches a
> > VS-stage leaf PTE whose accessed or dirty bit is clear triggers a
> > hardware write-back of those bits into the PTE. That write-back is an
> > implicit store to the PTE's guest-physical address, so it must be
> > permitted by G-stage.
> >
> > Fix this by re-running the G-stage translation of the guest PTE's
> > address with store semantics. get_physical_address() then also checks
> > that G-stage permits the guest PTE to be written, and raises a
> > guest-page store fault when it does not.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3426
> > Signed-off-by: imaginos <imaginos32@gmail.com>
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>
> Alistair
>
> > ---
> >  target/riscv/cpu_helper.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> >  v2:
> >    Reword an incomplete sentence in the code comment.
> >
> >  Verified against Spike, with this patch QEMU's
> >  reported values match Spike.
> >
> >  Spike (reference):        QEMU, before this patch:
> >     mcause 0x17               mcause 0x17
> >     mtval  0x80000000         mtval  0x80000000
> >     mtval2 0x20001004         mtval2 0x20000000
> >     mtinst 0x3020             mtinst 0x6a704073
> >
> >  If I've misread any of the A/D-update semantics here, I'd appreciate
> > the
> >  correction.
> >
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > index 2db07f5dfb..eb34ba19e1 100644
> > --- a/target/riscv/cpu_helper.c
> > +++ b/target/riscv/cpu_helper.c
> > @@ -1370,6 +1370,7 @@ static int get_physical_address(CPURISCVState
> > *env, hwaddr *physical,
> >      int ptshift;
> >      target_ulong pte;
> >      hwaddr pte_addr;
> > +    hwaddr pte_gpa =3D 0;
> >      const hwaddr base_root =3D base;
> >      const bool be =3D mo_endian_env(env) =3D=3D MO_BE;
> >      int i;
> > @@ -1407,6 +1408,7 @@ static int get_physical_address(CPURISCVState
> > *env, hwaddr *physical,
> >              }
> >
> >              pte_addr =3D vbase + idx * ptesize;
> > +            pte_gpa =3D base + idx * ptesize;
> >          } else {
> >              pte_addr =3D base + idx * ptesize;
> >          }
> > @@ -1661,6 +1663,28 @@ static int get_physical_address(CPURISCVState
> > *env, hwaddr *physical,
> >              return TRANSLATE_FAIL;
> >          }
> >
> > +        /*
> > +         * The implicit store that writes updated A/D bits back to a
> > VS-stage
> > +         * (first-stage) PTE must itself be permitted by G-stage.
> > Re-run the
> > +         * second-stage translation of the PTE's guest-physical
> > address with
> > +         * store semantics. If G-stage denies write, raise G-stage
> > store fault
> > +         * against the PTE address.
> > +         */
> > +        if (two_stage && first_stage) {
> > +            int gpa_prot;
> > +            hwaddr gpa_paddr;
> > +            int gpa_ret =3D get_physical_address(env, &gpa_paddr,
> > &gpa_prot,
> > +                                               pte_gpa, NULL,
> > MMU_DATA_STORE,
> > +                                               MMUIdx_U, false,
> > true,
> > +                                               is_debug, false);
> > +            if (gpa_ret !=3D TRANSLATE_SUCCESS) {
> > +                if (fault_pte_addr) {
> > +                    *fault_pte_addr =3D pte_gpa >> 2;
> > +                }
> > +                return TRANSLATE_G_STAGE_FAIL;
> > +            }
> > +        }
> > +
> >          pmp_ret =3D get_physical_address_pmp(env, &pmp_prot, pte_addr,
> >                                             sxlen_bytes,
> > MMU_DATA_STORE, PRV_S);
> >          if (pmp_ret !=3D TRANSLATE_SUCCESS) {
> > @@ -2345,6 +2369,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
> >                   * doing VS-stage page table walk.
> >                   */
> >                  tinst =3D (riscv_cpu_xlen(env) =3D=3D 32) ? 0x00002000=
 :
> > 0x00003000;
> > +
> > +                if (cause =3D=3D
> > RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT) {
> > +                    tinst |=3D 0x20;
> > +                }
> >              } else {
> >                  /*
> >                   * The "Addr. Offset" field in transformed
> > instruction is
>

--0000000000008347c2065a9b0d6c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+SnVzdCBmb2xsb3dpbmcgdXAgdG8gcGluZyB0aGUgcGF0Y2ggYWdhaW48
L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUgZ21haWxfcXVvdGVfY29udGFpbmVyIj48
ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+0L/QtdGCLCAxMC4g0ZjRg9C7IDIwMjYu
INGDIDA0OjIzIEFsaXN0YWlyIEZyYW5jaXMgJmx0OzxhIGhyZWY9Im1haWx0bzpBbGlzdGFpci5G
cmFuY2lzQHdkYy5jb20iPkFsaXN0YWlyLkZyYW5jaXNAd2RjLmNvbTwvYT4mZ3Q7INGY0LUg0L3Q
sNC/0LjRgdCw0L4v0LvQsDo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3Rl
IiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCBy
Z2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPk9uIFN1biwgMjAyNi0wNy0wNSBhdCAx
NjowMiArMDIwMCwgaW1hZ2lub3Mgd3JvdGU6PGJyPg0KJmd0OyBEdXJpbmcgYSB0d28tc3RhZ2Ug
KFZTLXN0YWdlICsgRy1zdGFnZSkgcGFnZS10YWJsZSB3YWxrIHdpdGggaGFyZHdhcmU8YnI+DQom
Z3Q7IEEvRCB1cGRhdGluZyBlbmFibGVkIChTdmFkdSAvIG1lbnZjZmcuQURVRSksIGEgc3RvcmUg
dGhhdCByZWFjaGVzIGE8YnI+DQomZ3Q7IFZTLXN0YWdlIGxlYWYgUFRFIHdob3NlIGFjY2Vzc2Vk
IG9yIGRpcnR5IGJpdCBpcyBjbGVhciB0cmlnZ2VycyBhPGJyPg0KJmd0OyBoYXJkd2FyZSB3cml0
ZS1iYWNrIG9mIHRob3NlIGJpdHMgaW50byB0aGUgUFRFLiBUaGF0IHdyaXRlLWJhY2sgaXMgYW48
YnI+DQomZ3Q7IGltcGxpY2l0IHN0b3JlIHRvIHRoZSBQVEUmIzM5O3MgZ3Vlc3QtcGh5c2ljYWwg
YWRkcmVzcywgc28gaXQgbXVzdCBiZTxicj4NCiZndDsgcGVybWl0dGVkIGJ5IEctc3RhZ2UuPGJy
Pg0KJmd0OyA8YnI+DQomZ3Q7IEZpeCB0aGlzIGJ5IHJlLXJ1bm5pbmcgdGhlIEctc3RhZ2UgdHJh
bnNsYXRpb24gb2YgdGhlIGd1ZXN0IFBURSYjMzk7czxicj4NCiZndDsgYWRkcmVzcyB3aXRoIHN0
b3JlIHNlbWFudGljcy4gZ2V0X3BoeXNpY2FsX2FkZHJlc3MoKSB0aGVuIGFsc28gY2hlY2tzPGJy
Pg0KJmd0OyB0aGF0IEctc3RhZ2UgcGVybWl0cyB0aGUgZ3Vlc3QgUFRFIHRvIGJlIHdyaXR0ZW4s
IGFuZCByYWlzZXMgYTxicj4NCiZndDsgZ3Vlc3QtcGFnZSBzdG9yZSBmYXVsdCB3aGVuIGl0IGRv
ZXMgbm90Ljxicj4NCiZndDsgPGJyPg0KJmd0OyBSZXNvbHZlczogPGEgaHJlZj0iaHR0cHM6Ly9n
aXRsYWIuY29tL3FlbXUtcHJvamVjdC9xZW11Ly0vd29ya19pdGVtcy8zNDI2IiByZWw9Im5vcmVm
ZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L3Fl
bXUvLS93b3JrX2l0ZW1zLzM0MjY8L2E+PGJyPg0KJmd0OyBTaWduZWQtb2ZmLWJ5OiBpbWFnaW5v
cyAmbHQ7PGEgaHJlZj0ibWFpbHRvOmltYWdpbm9zMzJAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFu
ayI+aW1hZ2lub3MzMkBnbWFpbC5jb208L2E+Jmd0Ozxicj4NCjxicj4NClJldmlld2VkLWJ5OiBB
bGlzdGFpciBGcmFuY2lzICZsdDs8YSBocmVmPSJtYWlsdG86YWxpc3RhaXIuZnJhbmNpc0B3ZGMu
Y29tIiB0YXJnZXQ9Il9ibGFuayI+YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPC9hPiZndDs8YnI+
DQo8YnI+DQpBbGlzdGFpcjxicj4NCjxicj4NCiZndDsgLS0tPGJyPg0KJmd0OyDCoHRhcmdldC9y
aXNjdi9jcHVfaGVscGVyLmMgfCAyOCArKysrKysrKysrKysrKysrKysrKysrKysrKysrPGJyPg0K
Jmd0OyDCoDEgZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspPGJyPg0KJmd0OyA8YnI+DQom
Z3Q7IMKgdjI6PGJyPg0KJmd0OyDCoMKgIFJld29yZCBhbiBpbmNvbXBsZXRlIHNlbnRlbmNlIGlu
IHRoZSBjb2RlIGNvbW1lbnQuPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IMKgVmVyaWZpZWQgYWdhaW5z
dCBTcGlrZSwgd2l0aCB0aGlzIHBhdGNoIFFFTVUmIzM5O3M8YnI+DQomZ3Q7IMKgcmVwb3J0ZWQg
dmFsdWVzIG1hdGNoIFNwaWtlLjxicj4NCiZndDsgPGJyPg0KJmd0OyDCoFNwaWtlIChyZWZlcmVu
Y2UpOsKgwqDCoMKgwqDCoMKgIFFFTVUsIGJlZm9yZSB0aGlzIHBhdGNoOjxicj4NCiZndDsgwqDC
oMKgIG1jYXVzZSAweDE3wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtY2F1c2UgMHgxNzxi
cj4NCiZndDsgwqDCoMKgIG10dmFswqAgMHg4MDAwMDAwMMKgwqDCoMKgwqDCoMKgwqAgbXR2YWzC
oCAweDgwMDAwMDAwPGJyPg0KJmd0OyDCoMKgwqAgbXR2YWwyIDB4MjAwMDEwMDTCoMKgwqDCoMKg
wqDCoMKgIG10dmFsMiAweDIwMDAwMDAwPGJyPg0KJmd0OyDCoMKgwqAgbXRpbnN0IDB4MzAyMMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtdGluc3QgMHg2YTcwNDA3Mzxicj4NCiZndDsgPGJyPg0K
Jmd0OyDCoElmIEkmIzM5O3ZlIG1pc3JlYWQgYW55IG9mIHRoZSBBL0QtdXBkYXRlIHNlbWFudGlj
cyBoZXJlLCBJJiMzOTtkIGFwcHJlY2lhdGU8YnI+DQomZ3Q7IHRoZTxicj4NCiZndDsgwqBjb3Jy
ZWN0aW9uLjxicj4NCiZndDsgPGJyPg0KJmd0OyBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L2Nw
dV9oZWxwZXIuYyBiL3RhcmdldC9yaXNjdi9jcHVfaGVscGVyLmM8YnI+DQomZ3Q7IGluZGV4IDJk
YjA3ZjVkZmIuLmViMzRiYTE5ZTEgMTAwNjQ0PGJyPg0KJmd0OyAtLS0gYS90YXJnZXQvcmlzY3Yv
Y3B1X2hlbHBlci5jPGJyPg0KJmd0OyArKysgYi90YXJnZXQvcmlzY3YvY3B1X2hlbHBlci5jPGJy
Pg0KJmd0OyBAQCAtMTM3MCw2ICsxMzcwLDcgQEAgc3RhdGljIGludCBnZXRfcGh5c2ljYWxfYWRk
cmVzcyhDUFVSSVNDVlN0YXRlPGJyPg0KJmd0OyAqZW52LCBod2FkZHIgKnBoeXNpY2FsLDxicj4N
CiZndDsgwqDCoMKgwqAgaW50IHB0c2hpZnQ7PGJyPg0KJmd0OyDCoMKgwqDCoCB0YXJnZXRfdWxv
bmcgcHRlOzxicj4NCiZndDsgwqDCoMKgwqAgaHdhZGRyIHB0ZV9hZGRyOzxicj4NCiZndDsgK8Kg
wqDCoCBod2FkZHIgcHRlX2dwYSA9IDA7PGJyPg0KJmd0OyDCoMKgwqDCoCBjb25zdCBod2FkZHIg
YmFzZV9yb290ID0gYmFzZTs8YnI+DQomZ3Q7IMKgwqDCoMKgIGNvbnN0IGJvb2wgYmUgPSBtb19l
bmRpYW5fZW52KGVudikgPT0gTU9fQkU7PGJyPg0KJmd0OyDCoMKgwqDCoCBpbnQgaTs8YnI+DQom
Z3Q7IEBAIC0xNDA3LDYgKzE0MDgsNyBAQCBzdGF0aWMgaW50IGdldF9waHlzaWNhbF9hZGRyZXNz
KENQVVJJU0NWU3RhdGU8YnI+DQomZ3Q7ICplbnYsIGh3YWRkciAqcGh5c2ljYWwsPGJyPg0KJmd0
OyDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfTxicj4NCiZndDsgwqA8YnI+DQomZ3Q7IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBwdGVfYWRkciA9IHZiYXNlICsgaWR4ICogcHRlc2l6ZTs8YnI+
DQomZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHB0ZV9ncGEgPSBiYXNlICsgaWR4ICogcHRl
c2l6ZTs8YnI+DQomZ3Q7IMKgwqDCoMKgwqDCoMKgwqAgfSBlbHNlIHs8YnI+DQomZ3Q7IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBwdGVfYWRkciA9IGJhc2UgKyBpZHggKiBwdGVzaXplOzxicj4N
CiZndDsgwqDCoMKgwqDCoMKgwqDCoCB9PGJyPg0KJmd0OyBAQCAtMTY2MSw2ICsxNjYzLDI4IEBA
IHN0YXRpYyBpbnQgZ2V0X3BoeXNpY2FsX2FkZHJlc3MoQ1BVUklTQ1ZTdGF0ZTxicj4NCiZndDsg
KmVudiwgaHdhZGRyICpwaHlzaWNhbCw8YnI+DQomZ3Q7IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCByZXR1cm4gVFJBTlNMQVRFX0ZBSUw7PGJyPg0KJmd0OyDCoMKgwqDCoMKgwqDCoMKgIH08YnI+
DQomZ3Q7IMKgPGJyPg0KJmd0OyArwqDCoMKgwqDCoMKgwqAgLyo8YnI+DQomZ3Q7ICvCoMKgwqDC
oMKgwqDCoMKgICogVGhlIGltcGxpY2l0IHN0b3JlIHRoYXQgd3JpdGVzIHVwZGF0ZWQgQS9EIGJp
dHMgYmFjayB0byBhPGJyPg0KJmd0OyBWUy1zdGFnZTxicj4NCiZndDsgK8KgwqDCoMKgwqDCoMKg
wqAgKiAoZmlyc3Qtc3RhZ2UpIFBURSBtdXN0IGl0c2VsZiBiZSBwZXJtaXR0ZWQgYnkgRy1zdGFn
ZS48YnI+DQomZ3Q7IFJlLXJ1biB0aGU8YnI+DQomZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgICogc2Vj
b25kLXN0YWdlIHRyYW5zbGF0aW9uIG9mIHRoZSBQVEUmIzM5O3MgZ3Vlc3QtcGh5c2ljYWw8YnI+
DQomZ3Q7IGFkZHJlc3Mgd2l0aDxicj4NCiZndDsgK8KgwqDCoMKgwqDCoMKgwqAgKiBzdG9yZSBz
ZW1hbnRpY3MuIElmIEctc3RhZ2UgZGVuaWVzIHdyaXRlLCByYWlzZSBHLXN0YWdlPGJyPg0KJmd0
OyBzdG9yZSBmYXVsdDxicj4NCiZndDsgK8KgwqDCoMKgwqDCoMKgwqAgKiBhZ2FpbnN0IHRoZSBQ
VEUgYWRkcmVzcy48YnI+DQomZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgICovPGJyPg0KJmd0OyArwqDC
oMKgwqDCoMKgwqAgaWYgKHR3b19zdGFnZSAmYW1wOyZhbXA7IGZpcnN0X3N0YWdlKSB7PGJyPg0K
Jmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQgZ3BhX3Byb3Q7PGJyPg0KJmd0OyArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBod2FkZHIgZ3BhX3BhZGRyOzxicj4NCiZndDsgK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgaW50IGdwYV9yZXQgPSBnZXRfcGh5c2ljYWxfYWRkcmVzcyhlbnYsICZh
bXA7Z3BhX3BhZGRyLDxicj4NCiZndDsgJmFtcDtncGFfcHJvdCw8YnI+DQomZ3Q7ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwdGVfZ3BhLCBOVUxMLDxicj4NCiZndDsgTU1V
X0RBVEFfU1RPUkUsPGJyPg0KJmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgTU1VSWR4X1UsIGZhbHNlLDxicj4NCiZndDsgdHJ1ZSw8YnI+DQomZ3Q7ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpc19kZWJ1ZywgZmFsc2UpOzxicj4NCiZndDsgK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGdwYV9yZXQgIT0gVFJBTlNMQVRFX1NVQ0NFU1MpIHs8
YnI+DQomZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGZhdWx0X3B0ZV9h
ZGRyKSB7PGJyPg0KJmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
KmZhdWx0X3B0ZV9hZGRyID0gcHRlX2dwYSAmZ3Q7Jmd0OyAyOzxicj4NCiZndDsgK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9PGJyPg0KJmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybiBUUkFOU0xBVEVfR19TVEFHRV9GQUlMOzxicj4NCiZndDsgK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfTxicj4NCiZndDsgK8KgwqDCoMKgwqDCoMKgIH08YnI+DQomZ3Q7
ICs8YnI+DQomZ3Q7IMKgwqDCoMKgwqDCoMKgwqAgcG1wX3JldCA9IGdldF9waHlzaWNhbF9hZGRy
ZXNzX3BtcChlbnYsICZhbXA7cG1wX3Byb3QsIHB0ZV9hZGRyLDxicj4NCiZndDsgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgc3hsZW5fYnl0ZXMsPGJyPg0KJmd0OyBNTVVfREFUQV9TVE9S
RSwgUFJWX1MpOzxicj4NCiZndDsgwqDCoMKgwqDCoMKgwqDCoCBpZiAocG1wX3JldCAhPSBUUkFO
U0xBVEVfU1VDQ0VTUykgezxicj4NCiZndDsgQEAgLTIzNDUsNiArMjM2OSwxMCBAQCB2b2lkIHJp
c2N2X2NwdV9kb19pbnRlcnJ1cHQoQ1BVU3RhdGUgKmNzKTxicj4NCiZndDsgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGRvaW5nIFZTLXN0YWdlIHBhZ2UgdGFibGUgd2Fsay48
YnI+DQomZ3Q7IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi88YnI+DQomZ3Q7
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRpbnN0ID0gKHJpc2N2X2NwdV94bGVu
KGVudikgPT0gMzIpID8gMHgwMDAwMjAwMCA6PGJyPg0KJmd0OyAweDAwMDAzMDAwOzxicj4NCiZn
dDsgKzxicj4NCiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoY2F1c2Ug
PT08YnI+DQomZ3Q7IFJJU0NWX0VYQ1BfU1RPUkVfR1VFU1RfQU1PX0FDQ0VTU19GQVVMVCkgezxi
cj4NCiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRpbnN0IHw9
IDB4MjA7PGJyPg0KJmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH08YnI+DQom
Z3Q7IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9IGVsc2Ugezxicj4NCiZndDsgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyo8YnI+DQomZ3Q7IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgKiBUaGUgJnF1b3Q7QWRkci4gT2Zmc2V0JnF1b3Q7IGZpZWxkIGluIHRy
YW5zZm9ybWVkPGJyPg0KJmd0OyBpbnN0cnVjdGlvbiBpczxicj4NCjwvYmxvY2txdW90ZT48L2Rp
dj4NCg==
--0000000000008347c2065a9b0d6c--

