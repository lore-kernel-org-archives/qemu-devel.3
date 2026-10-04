Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F330ECA5FE6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 07:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDGbQ-0000pe-QQ; Sun, 04 Oct 2026 03:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xDGb5-0000p1-98
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 03:25:26 -0400
Received: from mail-ed2-x2b.google.com ([2a00:1450:4864:33::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xDGb2-0005sk-KO
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 03:25:22 -0400
Received: by mail-ed2-x2b.google.com with SMTP id
 4fb4d7f45d1cf-6ae42b3e901so483636a12.0
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 00:25:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791098718; cv=none;
 d=google.com; s=arc-20260327;
 b=nMcZDJwqgGOeJyAR/G5M9afgMOoDfuJZBYF1+R8TzF20k9WP9yYGvfFtme8KRfcssn
 qXMPdb3fdBipc8knshbFxZnxBFeKScg1YFuXKk+Zrr+IvBefU4MFRgmP8wF6pBpOCJH1
 RMRxHoq8t83TPqSYbsoCMNHnObrWpkc/p1OE5TUzjKELSsqQpXAl438krM/lqrBqx6d+
 hM/Kw/GipdJB8hf3ZbtAtYF7Dp8y5U/0CsTcDb0pP4sU2oke2kz26Qer/xwkB1EJPF0M
 m09Gz98jWrlBj5iRoOevK7qEESb9JNb6WFVOfsx2kemmM1UG2aHPFk6sydHu/G1ReLdw
 yHbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SWhdwpHuOLEI4Sb02GS3BiXpQIdT9edjH/DDBeQqrJI=;
 fh=Ubd+T4N1G56OBO/hTjfm+Yb/26pabtZ7OhCz6EcFcuM=;
 b=ElYBzUnadMjPaECJMe8VN0aZTGlxRYQJSd1eHUIBzPZ4cNBNq8hyaAbGv0uA0cqDFF
 5R3bXve6SJNQYynwpgkCZ+69aAczccVDpN1QDZZ8puUKXW/OmB+Sl93KiI491ceEZxXj
 nSAXNCegWxvDFVW1f0ZzIe6jfeAbxzosBo3hhAtX4Ua2e4mOpEltocVxfSXVFrEaMSu/
 3GRMLQGLLyf9s1jUTtzQbuNXztEEeYNwjt7Lp1h4zbglmsSvVpnI7H0yYR0h42BDo2q1
 i2dyOGNbUOGMouRgbAPMaodv3IJwvcSpkue8kP19eBd3qJ897NC29Id1+72bJFfNZ6M5
 wxnQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791098718; x=1791703518; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SWhdwpHuOLEI4Sb02GS3BiXpQIdT9edjH/DDBeQqrJI=;
 b=iNITXuJC4Jda7ItfnTgCIy08rGEjTcYGWe1Gx7su2RuJ2UNzebBM4J3eSTLqm4HPRb
 wjLp9BD9H9ZtrmZc5DhAMTX5kawxBvkCjR354Z34ZMa5f7qn5vAWti71xaZJA7ZSYxSh
 7cb1YtC3xnhCYEZE51K9FWOeaM03W0MlyJ/KxcklYNWTLcfi1rJZ/54HDCcLjC1XvVeX
 vl1ZeWS1NS4W+5xdCrNZseq8vR4R6BsAGBuUC1kLEoKl8QQLWhXq/5d3w9nAU5J2fHL6
 NGOGc42iJ6fOdEsbMI9jgwf4mayyIEQUwN1wGe895pG54Zg+NzGem4xxUAjycXTP4Aw0
 J1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791098718; x=1791703518;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SWhdwpHuOLEI4Sb02GS3BiXpQIdT9edjH/DDBeQqrJI=;
 b=kF+2r1fHGovYmUwOxWVWImEi9TtJMHcyia0nWGEDtk/lk6E3lp1wVZLoddyQbfUTU0
 r8/rusZvjLeO1rQF+QDNFz8XT5NgC3VKBYrbqruJ9lDCaTVOKq67boHmp5S9WuXGC9zg
 km/EQRbY2LDUD5jKctQSogaRkniB77HY67OvlQiIVcuVkqDOsRMnimjYZ4n5oy5PS5Pt
 jmu7hsfx+yIaWNTJ8zTRbhTKWN6HGsoWM/V4vZmSEEBr7rhEByJRePYUkixI7wy+JD7f
 CNruF6jbAQtrJ4p9mNiyg7N8pS4BrngU3o/DEl99RH7xmUC1N1kdNH66WO0OrHZJ4abc
 nSJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwOSExWwEJUXuMJ7ybrtaI/RusPnPhIRLbIT5JI9dXZCCZt+ASBP46FzWayaNPn0nOPnXltjmslhyxf@nongnu.org
X-Gm-Message-State: AFq9FYKk3XIO0UgF9f+nB3WSbY1pMdavqZbpcyutqcoQQD26dN+AH2TE
 L7m95BMGJ6T3deikZvZ/YeuSrqkVM9FV5cyZg6RT7koppDlqvF/Zo/yiCin1YMgZFcSMNoZ+zTG
 OqCrUJiqNycBVzs01/rM74MyTAnQVr00=
X-Gm-Gg: AYBFou2Pz74G0WaAxR6Y76kLAZNQC9/BOvkXepFpcqIH+nyoTKkvTN9rlC7/Wob4Fu2
 rEAgU/tZAiudaB2hYzdiFnsBBnhOuVSTYCqiS18KAHUY+Sor22xmqXwVKc2hQ1MrId9VE8KFtth
 zXNkqKmffyBpVZl5usCqjxx5G5H7ML0AkeeeqlrRS7Hh1A/QBqGcL8cOqb5PR8GYkNYmIjiIqxz
 hejso10baYvMQfwUSPnsHIwxXWRE8lyyNIQFgrunPz49i8r62l3Mep+rnxvY0I1TJHvoF8LDxSX
 xH6oKaFc8JWR4jhr5U0PBAlz7HSyUjj3EEuWgaRBvccPUUyckokOkL4=
X-Received: by 2002:a05:6402:454c:b0:6ac:8d79:9e13 with SMTP id
 4fb4d7f45d1cf-6af9e2cb9c6mr4732439a12.6.1791098717796; Sun, 04 Oct 2026
 00:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <20261002091518.1139575-1-pbonzini@redhat.com>
 <c6a89114-120e-49eb-b62b-be3038cdfc1d@linaro.org>
In-Reply-To: <c6a89114-120e-49eb-b62b-be3038cdfc1d@linaro.org>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Sun, 4 Oct 2026 15:25:04 +0800
X-Gm-Features: AclHuK9B9uwn_iXcT_qjpJKGb7M6gijMVIaqQLRA0-_yIe-DDTeZ4Y0GaRC-MHI
Message-ID: <CAE2XoE9WMLhNdiz-0OT0cgeTtWa+xbroxw-WnB8k-LergUHuvQ@mail.gmail.com>
Subject: Re: [PULL v2 00/32] target/i386 and misc changes for 2026-09-28
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Content-Type: multipart/mixed; boundary="000000000000d53440065cfeaa1b"
Received-SPF: pass client-ip=2a00:1450:4864:33::2b;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000d53440065cfeaa1b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Found the cause, the mutex is not always initialized, we need to check
if it's available.
Maybe a better way is to get the mutex to have no need to initialize.
Like pthread_mutex_t

On Sat, Oct 3, 2026 at 8:17=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/2/26 11:15, Paolo Bonzini wrote:
> > The following changes since commit 9c88811b81a935a172c5c873b2ada2d9b38a=
5f74:
> >
> >    Merge tag 'pull-target-arm-20260929' of https://gitlab.com/pm215/qem=
u into staging (2026-09-30 06:25:37 +0100)
> >
> > are available in the Git repository at:
> >
> >    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> >
> > for you to fetch changes up to 7b596a6918055eee8e17a78c84127b934ae4531e=
:
> >
> >    agents: Add a skill for finding your way around QEMU (2026-10-02 11:=
11:37 +0200)
> >
> > v1->v2: move validate_vex() before all operand decoding (patches 6-8)
> >
> > ----------------------------------------------------------------
> > * target/i386/tcg: fix EFLAGS reads in TCG plugin callbacks
> > * target/i386/tcg: raise #GP(0) on null SS load with RPL !=3D CPL
> > * target/i386/tcg: Don't clear C1 for FCOMI/FCOMIP/FUCOMI/FUCOMIP
> > * target/i386/tcg: implement APX
> > * target/i386: Migrate error code only with an exception
> > * agents: Add a skill for finding your way around QEMU
> > * tdx: fix buffer overflow in tdx_parse_panic_message
> > * accel/kvm: fixes
>
> This has a number of failures:
>
> https://gitlab.com/qemu-project/qemu/-/jobs/16911681150#L902
>
> I tried bisecting the issue to make sure, but the patch set isn't
> bisectable.  At
>
> commit a6d1cac8651b2a2d5eb56abbe1cea698e72e4e3f (HEAD)
> Author: Paolo Bonzini <pbonzini@redhat.com>
> Date:   Wed Sep 23 14:33:32 2026 +0200
>
>      target/i386/tcg: use zextT1 for CMPXCHG
>
> I get
>
> In file included from ../publish/target/i386/tcg/translate.c:3339:
> ../publish/target/i386/tcg/decode-new.c.inc:2765:10: error: use of
> undeclared identifier 'X86_EVEX_APX'; did you mean 'X86_VEX_LIG'?
>   2765 |     case X86_EVEX_APX:
>        |          ^~~~~~~~~~~~
>        |          X86_VEX_LIG
> ../publish/target/i386/tcg/decode-new.h:273:5: note: 'X86_VEX_LIG'
> declared here
>    273 |     X86_VEX_LIG,
>        |     ^
> In file included from ../publish/target/i386/tcg/translate.c:3339:
> ../publish/target/i386/tcg/decode-new.c.inc:2766:10: error: use of
> undeclared identifier 'X86_EVEX_APX_cmp'
>   2766 |     case X86_EVEX_APX_cmp:
>        |          ^~~~~~~~~~~~~~~~
> ../publish/target/i386/tcg/decode-new.c.inc:2767:10: error: use of
> undeclared identifier 'X86_EVEX_APX_pp2'
>   2767 |     case X86_EVEX_APX_pp2:
>        |          ^~~~~~~~~~~~~~~~
> ../publish/target/i386/tcg/decode-new.c.inc:2768:10: error: use of
> undeclared identifier 'X86_EVEX_APX_zu'
>   2768 |     case X86_EVEX_APX_zu:
>        |          ^~~~~~~~~~~~~~~
> 4 errors generated.
>
>
> r~
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000d53440065cfeaa1b
Content-Type: text/plain; charset="US-ASCII"; 
	name="0001-accel-kvm-protect-kvm_resample_fd_list-with-a-mutex.patch"
Content-Disposition: attachment; 
	filename="0001-accel-kvm-protect-kvm_resample_fd_list-with-a-mutex.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_muthvjsk0>
X-Attachment-Id: f_muthvjsk0

RnJvbSBjZDRmNmM0YzFmNTAwOGFmNWUyMTEzMjdkMzJmMzBmYTE0NTNjZjU1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXhpbSBMZXZpdHNreSA8bWxldml0c2tAcmVkaGF0LmNvbT4K
RGF0ZTogVHVlLCAyMiBTZXAgMjAyNiAyMDo0Njo1MSAtMDQwMApTdWJqZWN0OiBbUEFUQ0hdIGFj
Y2VsL2t2bTogcHJvdGVjdCBrdm1fcmVzYW1wbGVfZmRfbGlzdCB3aXRoIGEgbXV0ZXgKCkxlZ2Fj
eSBQQ0kgSU5UeCBpbnRlcnJ1cHRzIGFyZSBsZXZlbCB0cmlnZ2VyZWQgYW5kIGNhbiwgaW4gdGhl
b3J5LCBiZSBzaGFyZWQuCgpVcG9uIHJlY2VpdmluZyBzdWNoIGFuIGludGVycnVwdCwgVkZJTyBr
ZXJuZWwgZHJpdmVyIG1hc2tzIGl0IGluIGEgZ2VuZXJpYyB3YXksCnVzaW5nIElOVFhfRElTQUJM
RSBiaXQgaW4gdGhlIFBDSSBjb25maWcgc3BhY2UuCgpJdCB0aGVuIHdhaXRzIGZvciB0aGUgZ3Vl
c3QgdG8gc2lnbmFsIGNvbXBsZXRpb24gKEVPSSkgb2YgdGhlIGludGVycnVwdCwKdXBvbiB3aGlj
aCBWRklPIHJlLWVuYWJsZXMgdGhlIGludGVycnVwdC4KClRoZSBjb21wbGV0aW9uIGlzIHNpZ25h
bGVkIHdpdGggYW5vdGhlciBldmVudGZkLgoKRm9yIHNwbGl0IGlycWNoaXAgbW9kZSwgS1ZNIGRv
ZXNuJ3QgaGF2ZSBhIG5vdGlvbiBvZiBFT0kgb24gSU9BUElDIGxldmVsLgpJbnN0ZWFkIGl0IHNp
Z25hbHMgRU9JIHdpdGggYSB1c2Vyc3BhY2UgVk0gZXhpdCwgS1ZNX0VYSVRfSU9BUElDX0VPSS4K
ClVwb24gcmVjZWl2aW5nIHRoaXMgVk0gZXhpdCwgUWVtdSBtYW51YWxseSBzaWduYWxzIHRoZSBh
Ym92ZS1tZW50aW9uZWQgZXZlbnRmZC4KClRoZSBwcm9ibGVtIHRoYXQgdGhpcyBwYXRjaCByZXNv
bHZlcyBpcyB0aGF0IFFFTVUga2VlcHMgdGhlc2UgZXZlbnRmZHMgaW4KYSBsaW5rZWQgbGlzdCB3
aXRob3V0IGFueSBsb2NraW5nIHRvIHByZXZlbnQgdGhlIGxpc3QgZnJvbSBiZWluZyBjb3JydXB0
ZWQgYnkKY29uY3VycmVudCBhY2Nlc3MuCgpTdWNoIHVzZSBpcyBwb3NzaWJsZSBhbmQgZ3Vlc3Qg
dHJpZ2dlcmFibGUgaWYgdGhlIGd1ZXN0IHJhcGlkbHkgdG9nZ2xlcwpJTlRYIG1vZGUgb2YgYSBW
RklPIGRldmljZSBhbmQgYXQgdGhlIHNhbWUgdGltZSBzaWduYWxzIEVPSSB3aXRoIGFuIGFyYml0
cmFyeQp2ZWN0b3IuCgpGaXggdGhpcyBieSBwcm90ZWN0aW5nIHRoaXMgbGlzdCAoa3ZtX3Jlc2Ft
cGxlX2ZkX2xpc3QpIHdpdGggYSBtdXRleC4KClRoaXMgcGF0Y2ggd2FzIG9ubHkgY29tcGlsZSB0
ZXN0ZWQuCgpSZXBvcnRlZC1ieTogIlZ1bG5lcmFiaWxpdHkgUmVwb3J0IiA8dnJAZGFya25hdnku
Y29tPgpSZXNvbHZlczogaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9xZW11Ly0vd29y
a19pdGVtcy8zOTQyClNpZ25lZC1vZmYtYnk6IE1heGltIExldml0c2t5IDxtbGV2aXRza0ByZWRo
YXQuY29tPgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjYwOTIzMDA0NjUxLjEw
MTE5Ny0xLW1sZXZpdHNrQHJlZGhhdC5jb20KU2lnbmVkLW9mZi1ieTogUGFvbG8gQm9uemluaSA8
cGJvbnppbmlAcmVkaGF0LmNvbT4KLS0tCiBhY2NlbC9rdm0va3ZtLWFsbC5jIHwgMTggKysrKysr
KysrKysrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQoKZGlmZiAtLWdpdCBhL2FjY2VsL2t2bS9rdm0tYWxsLmMgYi9hY2NlbC9rdm0va3ZtLWFs
bC5jCmluZGV4IDEzNGM3MWYzM2EuLjNjOTJiMGI5YWQgMTAwNjQ0Ci0tLSBhL2FjY2VsL2t2bS9r
dm0tYWxsLmMKKysrIGIvYWNjZWwva3ZtL2t2bS1hbGwuYwpAQCAtMTQ3LDYgKzE0Nyw3IEBAIHR5
cGVkZWYgc3RydWN0IEtWTVJlc2FtcGxlRmQgS1ZNUmVzYW1wbGVGZDsKIHN0YXRpYyBRTElTVF9I
RUFEKCwgS1ZNUmVzYW1wbGVGZCkga3ZtX3Jlc2FtcGxlX2ZkX2xpc3QgPQogICAgIFFMSVNUX0hF
QURfSU5JVElBTElaRVIoa3ZtX3Jlc2FtcGxlX2ZkX2xpc3QpOwogCitzdGF0aWMgUWVtdU11dGV4
IGt2bV9yZXNhbXBsZV9mZF9saXN0X2xvY2s7CiBzdGF0aWMgUWVtdU11dGV4IGttbF9zbG90c19s
b2NrOwogCiAjZGVmaW5lIGt2bV9zbG90c19sb2NrKCkgICAgcWVtdV9tdXRleF9sb2NrKCZrbWxf
c2xvdHNfbG9jaykKQEAgLTE1OCw2ICsxNTksOCBAQCBzdGF0aWMgaW5saW5lIHZvaWQga3ZtX3Jl
c2FtcGxlX2ZkX3JlbW92ZShpbnQgZ3NpKQogewogICAgIEtWTVJlc2FtcGxlRmQgKnJmZDsKIAor
ICAgIHFlbXVfbXV0ZXhfbG9jaygma3ZtX3Jlc2FtcGxlX2ZkX2xpc3RfbG9jayk7CisKICAgICBR
TElTVF9GT1JFQUNIKHJmZCwgJmt2bV9yZXNhbXBsZV9mZF9saXN0LCBub2RlKSB7CiAgICAgICAg
IGlmIChyZmQtPmdzaSA9PSBnc2kpIHsKICAgICAgICAgICAgIFFMSVNUX1JFTU9WRShyZmQsIG5v
ZGUpOwpAQCAtMTY1LDYgKzE2OCw4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBrdm1fcmVzYW1wbGVf
ZmRfcmVtb3ZlKGludCBnc2kpCiAgICAgICAgICAgICBicmVhazsKICAgICAgICAgfQogICAgIH0K
KworICAgIHFlbXVfbXV0ZXhfdW5sb2NrKCZrdm1fcmVzYW1wbGVfZmRfbGlzdF9sb2NrKTsKIH0K
IAogc3RhdGljIGlubGluZSB2b2lkIGt2bV9yZXNhbXBsZV9mZF9pbnNlcnQoaW50IGdzaSwgRXZl
bnROb3RpZmllciAqZXZlbnQpCkBAIC0xNzQsMjAgKzE3OSwzMCBAQCBzdGF0aWMgaW5saW5lIHZv
aWQga3ZtX3Jlc2FtcGxlX2ZkX2luc2VydChpbnQgZ3NpLCBFdmVudE5vdGlmaWVyICpldmVudCkK
ICAgICByZmQtPmdzaSA9IGdzaTsKICAgICByZmQtPnJlc2FtcGxlX2V2ZW50ID0gZXZlbnQ7CiAK
KyAgICBxZW11X211dGV4X2xvY2soJmt2bV9yZXNhbXBsZV9mZF9saXN0X2xvY2spOwogICAgIFFM
SVNUX0lOU0VSVF9IRUFEKCZrdm1fcmVzYW1wbGVfZmRfbGlzdCwgcmZkLCBub2RlKTsKKyAgICBx
ZW11X211dGV4X3VubG9jaygma3ZtX3Jlc2FtcGxlX2ZkX2xpc3RfbG9jayk7CiB9CiAKIHZvaWQg
a3ZtX3Jlc2FtcGxlX2ZkX25vdGlmeShpbnQgZ3NpKQogewogICAgIEtWTVJlc2FtcGxlRmQgKnJm
ZDsKIAorICAgIGlmICgha3ZtX2VuYWJsZWQoKSB8fCAha3ZtX2lycWNoaXBfaXNfc3BsaXQoKSkg
eworICAgICAgICByZXR1cm47CisgICAgfQorCisgICAgcWVtdV9tdXRleF9sb2NrKCZrdm1fcmVz
YW1wbGVfZmRfbGlzdF9sb2NrKTsKKwogICAgIFFMSVNUX0ZPUkVBQ0gocmZkLCAma3ZtX3Jlc2Ft
cGxlX2ZkX2xpc3QsIG5vZGUpIHsKICAgICAgICAgaWYgKHJmZC0+Z3NpID09IGdzaSkgewogICAg
ICAgICAgICAgZXZlbnRfbm90aWZpZXJfc2V0KHJmZC0+cmVzYW1wbGVfZXZlbnQpOwogICAgICAg
ICAgICAgdHJhY2Vfa3ZtX3Jlc2FtcGxlX2ZkX25vdGlmeShnc2kpOwotICAgICAgICAgICAgcmV0
dXJuOworICAgICAgICAgICAgYnJlYWs7CiAgICAgICAgIH0KICAgICB9CisKKyAgICBxZW11X211
dGV4X3VubG9jaygma3ZtX3Jlc2FtcGxlX2ZkX2xpc3RfbG9jayk7CiB9CiAKIC8qKgpAQCAtMjkx
Niw2ICsyOTMxLDcgQEAgc3RhdGljIGludCBrdm1faW5pdChBY2NlbFN0YXRlICphcywgTWFjaGlu
ZVN0YXRlICptcykKICAgICBpbnQgdHlwZTsKIAogICAgIHFlbXVfbXV0ZXhfaW5pdCgma21sX3Ns
b3RzX2xvY2spOworICAgIHFlbXVfbXV0ZXhfaW5pdCgma3ZtX3Jlc2FtcGxlX2ZkX2xpc3RfbG9j
ayk7CiAKICAgICAvKgogICAgICAqIE9uIHN5c3RlbXMgd2hlcmUgdGhlIGtlcm5lbCBjYW4gc3Vw
cG9ydCBkaWZmZXJlbnQgYmFzZSBwYWdlCi0tIAoyLjU1LjAud2luZG93cy4zCgo=
--000000000000d53440065cfeaa1b--

