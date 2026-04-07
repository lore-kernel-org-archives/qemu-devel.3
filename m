Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0343FF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABVv-0007Wz-Ej; Tue, 07 Apr 2026 14:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wABTl-0004Gt-8v
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:48:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wA3rq-0005Oc-Ij
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 06:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775558466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v+eezsYA2JqlbT8f/6WoNRXz1UDCXKGIYdbPcDx165w=;
 b=HzC6GeNCQftaXBoe39to3Ko7RjQRMYFFEZXSasNKsoSJFTJx94qoBihzwEwWLufX/bP1BD
 5bcCj8WyE7pscKnBU8NdYkOe0QfevZ8qM7H5yxkSz//JhOQVJdQeB+x/i/FuC2vVgrJ7Lm
 AZ4+gQST+n8qj0xo257SD0SIvlS99Do=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-PaWPqLiaNMmcceij-KAaLA-1; Tue, 07 Apr 2026 06:41:04 -0400
X-MC-Unique: PaWPqLiaNMmcceij-KAaLA-1
X-Mimecast-MFC-AGG-ID: PaWPqLiaNMmcceij-KAaLA_1775558463
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35842aa350fso11416110a91.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 03:41:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775558463; cv=none;
 d=google.com; s=arc-20240605;
 b=gWCiKrLEjput0SQpB0+EAAnjsftmzVqL4JVcQLVR5Ova8l7FAII/cseQFiqpxsbwZP
 2ONjhkNWz93niQmHuouA+9r1ho/E0wpOYZeHhaPXTou5fynbCJgpS+XpCTg7hKvm6lYH
 Gi2Va5kzxEw9PQo4Twiy+1utygRuMT0I1h9xNCGdUr2a7TcJI5Ua3lvT6CAriKGE2+tL
 MB3y7+CWkIm+CQAJiUGPG5jX9it8j/ROG+hSCUT/hHcN8mKIJS3YOjw2CpD33IFN7FME
 GYUuUNVssbv4QTP0L/ZBMGo2uDnBBCrGkj4M1Vl5AL4i23W6Brc9tNPcc34yDbL/tr/P
 Vy7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=v+eezsYA2JqlbT8f/6WoNRXz1UDCXKGIYdbPcDx165w=;
 fh=DjCsBAlzHiQ7urn9emqwzALbJ1ZadaQmzpiSJrrLJFk=;
 b=F+4sexAovCKpR30lMH/mBBrjKL3GU6faLlDEV4wS5Kkb1oUMAKY1EaRGzKLvPyt39z
 phko5ls76hdLe62CQEYI0Pvr8SGIwKNKQI8H23++UaIB3Lw/bcAjsB/ng/ac8tDZs1+U
 hX2AyjCWNSnS+kdRzq94JMdH7Adktxxrdhiyun23aJXHCVHyT0y57qh2S/7HQ2DDaQu/
 h88YBeE/kAJwE85pivoUYrf22laEHzJIGl0lenhVfPMle9HtSr5g9kbA/MgY13j4bZCt
 XHxIZ64AWa9u4AwUM3uzxbZMKyxFtQ3gxAqtsa9K6/jCByfhuaM9KOeX+CJ6JuDVgWNA
 2LMA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775558463; x=1776163263; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v+eezsYA2JqlbT8f/6WoNRXz1UDCXKGIYdbPcDx165w=;
 b=InFhSyVMP5Pi/LcsEQG6jpjRdCviV7cVCDA6aXb0GxiIAsxCPM34XGboHPQ6w0YJIz
 BU2Rj9ZiTNivl500ZIx2qNXpYlfgXde6o6NoD3ibX0WzX77RP1BxbWBPqhW+kktafuXT
 2DN7IBNV+wTTbvw+9dryDd4Q/8hP8dp811zEBtiyl9TpMEK6ulHf/AZgxOc4FxP38pHk
 unbam1tJwIi0jwOb4FHYhaUnXok3dYxnC7ivznJi8r9Fs3NlcMouD2ne10dQGtMkZuyd
 KK7kV8yYWoRf1YH/4TPZpAJMABjQ5/Slyn6eAlEcR9iBDrrGkjhmkxowqErFyJXxA7S5
 VEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775558463; x=1776163263;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v+eezsYA2JqlbT8f/6WoNRXz1UDCXKGIYdbPcDx165w=;
 b=H7uZA64p24VmJIt9mne8NTflVJGU+L0DwR4Q/tNLedJTzyXU5g6Mib3EPj/s43Ts35
 nMlmGztMmakuHFzjz/S43Ro6tujjuFxa5RMi4XX4foNbApHdkKPH//JIP9idc3NmpKkG
 R/E6+MSSeTYCWIe7TKxBEt1XDKgor3CX81O4u9u1xYmFKX4oL9QXYPMBBeG+Dr6UCJju
 xfcQ/y86O4rRUE1zQrx4OB3wUkAakkI4yyYX+subsM4r50b5t9ClAMYRGPDqi5x8zTWk
 0uwzXRSHCq32vz9WwwSwHP3gdKy1+iVONWs2VzLx7k2wdEe+JXhwG41EUsq6It/ZdXtk
 iyJQ==
X-Gm-Message-State: AOJu0YznGklY1EyPpcsqLMvecf6l14AuqcvAE6W6ySHQ9m+3OcFA4PVz
 KUlZ0tcYIm3fXZqW+20muRkuAsZqj+yTNPLLsUNNYtAi8ka8vNvNyOoNbsWmnqDLNbvGrKNZUcT
 KoM6Yttkkg4kH9HAi9ytqOl9un38HfJ5kjfasX0ac+kXXq/oh9SCAob7OCXs+BiaC0ArGgu2up6
 kju0NNUDx2ahmbYHsxabRIEU88yfKWgLk=
X-Gm-Gg: AeBDieuRPYR19C87VrkDAZUt+SuIXSSd8HXQ3dXGK6xxYGL9kvVqvXtTeTiVksZK5Ed
 5unPIwK2qgH1tBhtdxNPC6KmBc8r0tfnjQp+qTP9EOlrzCEYs491j4ASiLtEHZV6BaU9dGbAORV
 MKzmsO7Y7FEnGfujOi4B4Lw7zm9t/Zqq9b8AQCfTxHh6ygMLbtXLN+mXC5tT+6MFJXi5/Xpb5pg
 cmVtWYkZGwGMM5axwPLelymGH/0c4/yF5dXL2b+anOzX0vLJ34IxPTz/lDrqeL7vygRMA8io8p9
 QITWoc3ZXvFOA/W0ryy2LvQ=
X-Received: by 2002:a17:90b:35c8:b0:35b:ea35:c3ce with SMTP id
 98e67ed59e1d1-35de6952e00mr15916185a91.27.1775558463173; 
 Tue, 07 Apr 2026 03:41:03 -0700 (PDT)
X-Received: by 2002:a17:90b:35c8:b0:35b:ea35:c3ce with SMTP id
 98e67ed59e1d1-35de6952e00mr15916144a91.27.1775558462659; Tue, 07 Apr 2026
 03:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260406141735.25844-1-armenon@redhat.com>
 <20260406141735.25844-6-armenon@redhat.com>
In-Reply-To: <20260406141735.25844-6-armenon@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 7 Apr 2026 14:40:51 +0400
X-Gm-Features: AQROBzBPX_O0jjmnYFNNMK9DzWdntFwFTuSnY9I8SBpAsB7AKE1ixjLldGLnnqI
Message-ID: <CAMxuvaxU=1nds7QAysem_j0jSOM8DK-E0Y74xCs3kS35Se_JKQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] test/qtest: Add test for tpm crb chunking
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi

On Mon, Apr 6, 2026 at 6:18=E2=80=AFPM Arun Menon <armenon@redhat.com> wrot=
e:
>
> From: Arun Menon <armenon@redhat.com>
>
> - New test case added to the swtpm test. Data is written and read from
>   the buffer in chunks.
> - The chunk size is dynamically calculated by reading the
>   CRB_CTRL_CMD_SIZE address. This can be changed manually to test.
> - Add a helper function tpm_wait_till_bit_clear()
>
> Signed-off-by: Arun Menon <armenon@redhat.com>

This alone doesn't yet test the chunked write/read, as the transfers
aren't larger. The following patch "tests: Use ML-DSA-87 operations to
caused large TPM transfers with CRB" will. It may be worth to say in
the commit message

with other minor style nitpicks below

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  tests/qtest/tpm-crb-swtpm-test.c |  10 +++
>  tests/qtest/tpm-util.c           | 108 ++++++++++++++++++++++++++-----
>  tests/qtest/tpm-util.h           |   5 ++
>  3 files changed, 108 insertions(+), 15 deletions(-)
>
> diff --git a/tests/qtest/tpm-crb-swtpm-test.c b/tests/qtest/tpm-crb-swtpm=
-test.c
> index ffeb1c396b..050c7b0c1f 100644
> --- a/tests/qtest/tpm-crb-swtpm-test.c
> +++ b/tests/qtest/tpm-crb-swtpm-test.c
> @@ -33,6 +33,14 @@ static void tpm_crb_swtpm_test(const void *data)
>                          "tpm-crb", NULL);
>  }
>
> +static void tpm_crb_chunk_swtpm_test(const void *data)
> +{
> +    const TestState *ts =3D data;
> +
> +    tpm_test_swtpm_test(ts->src_tpm_path, tpm_util_crb_chunk_transfer,
> +                        "tpm-crb", NULL);
> +}
> +
>  static void tpm_crb_swtpm_migration_test(const void *data)
>  {
>      const TestState *ts =3D data;
> @@ -54,6 +62,8 @@ int main(int argc, char **argv)
>      g_test_init(&argc, &argv, NULL);
>
>      qtest_add_data_func("/tpm/crb-swtpm/test", &ts, tpm_crb_swtpm_test);
> +    qtest_add_data_func("/tpm/crb-chunk-swtpm/test", &ts,
> +                        tpm_crb_chunk_swtpm_test);
>      qtest_add_data_func("/tpm/crb-swtpm-migration/test", &ts,
>                          tpm_crb_swtpm_migration_test);
>      ret =3D g_test_run();
> diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
> index 2cb2dd4796..603c5a825d 100644
> --- a/tests/qtest/tpm-util.c
> +++ b/tests/qtest/tpm-util.c
> @@ -14,16 +14,44 @@
>
>  #include "qemu/osdep.h"
>  #include <glib/gstdio.h>
> +#include "qemu/bswap.h"
>
>  #include "hw/acpi/tpm.h"
>  #include "libqtest.h"
>  #include "tpm-util.h"
>  #include "qobject/qdict.h"
>
> +#define CRB_ADDR_START (TPM_CRB_ADDR_BASE + A_CRB_CTRL_START)
> +#define CRB_ADDR_CTRL_STS (TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS)
> +#define CRB_ADDR_CTRL_CMD_SIZE \
> +    (TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD_SIZE)
> +
> +#define CRB_START_INVOKE  (1 << 0)
> +#define CRB_START_RSP_RETRY (1 << 1)
> +#define CRB_START_NEXT_CHUNK (1 << 2)
> +
> +void tpm_wait_till_bit_clear(QTestState *s, uint64_t addr, uint32_t mask=
)
> +{
> +    uint32_t sts;
> +    uint64_t end_time =3D g_get_monotonic_time() + 5 * G_TIME_SPAN_SECON=
D;
> +
> +    while (true) {
> +        sts =3D qtest_readl(s, addr);
> +        if ((sts & mask) =3D=3D 0) {
> +            break;
> +        }
> +        if (g_get_monotonic_time() >=3D end_time) {
> +            g_assert_cmphex(sts & mask, =3D=3D, 0);
> +            break;
> +        }
> +    }
> +}
> +
>  void tpm_util_crb_transfer(QTestState *s,
>                             const unsigned char *req, size_t req_size,
>                             unsigned char *rsp, size_t rsp_size)
>  {
> +    uint32_t tpm_sts;
>      uint64_t caddr =3D qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD=
_LADDR);
>      uint64_t raddr =3D qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP=
_ADDR);
>
> @@ -31,24 +59,74 @@ void tpm_util_crb_transfer(QTestState *s,
>
>      qtest_memwrite(s, caddr, req, req_size);
>
> -    uint32_t sts, start =3D 1;
> -    uint64_t end_time =3D g_get_monotonic_time() + 5 * G_TIME_SPAN_SECON=
D;
> -    qtest_writel(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_START, start);
> -    while (true) {
> -        start =3D qtest_readl(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_START);
> -        if ((start & 1) =3D=3D 0) {
> -            break;
> +    qtest_writel(s, CRB_ADDR_START, CRB_START_INVOKE);
> +    tpm_wait_till_bit_clear(s, CRB_ADDR_START, CRB_START_INVOKE);
> +
> +    tpm_sts =3D qtest_readl(s, CRB_ADDR_CTRL_STS);
> +    g_assert_cmpint(tpm_sts & 1, =3D=3D, 0);
> +
> +    qtest_memread(s, raddr, rsp, rsp_size);
> +}
> +
> +void tpm_util_crb_chunk_transfer(QTestState *s,
> +                                 const unsigned char *req, size_t req_si=
ze,
> +                                 unsigned char *rsp, size_t rsp_size)
> +{
> +    uint32_t tpm_sts;
> +
> +    uint64_t caddr =3D qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD=
_LADDR);
> +    uint64_t raddr =3D qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP=
_ADDR);
> +    uint32_t crb_ctrl_cmd_size =3D qtest_readl(s, CRB_ADDR_CTRL_CMD_SIZE=
);
> +
> +    size_t chunk_size =3D crb_ctrl_cmd_size;
> +
> +    qtest_writeb(s, TPM_CRB_ADDR_BASE + A_CRB_LOC_CTRL, 1);
> +
> +    for (size_t i =3D 0 ; i < req_size; i +=3D chunk_size) {

extra space before ;

> +        bool last_chunk =3D false;
> +        size_t current_chunk_size =3D chunk_size;
> +
> +        if (i + chunk_size > req_size) {
> +            last_chunk =3D true;
> +            current_chunk_size =3D req_size - i;
>          }
> -        if (g_get_monotonic_time() >=3D end_time) {
> -            break;
> +
> +        qtest_memwrite(s, caddr, req + i, current_chunk_size);
> +
> +        if (last_chunk) {
> +            qtest_writel(s, CRB_ADDR_START, CRB_START_INVOKE);
> +            tpm_wait_till_bit_clear(s, CRB_ADDR_START, CRB_START_INVOKE)=
;
> +        } else {
> +            qtest_writel(s, CRB_ADDR_START , CRB_START_NEXT_CHUNK);

extra space after START

> +            tpm_wait_till_bit_clear(s, CRB_ADDR_START, CRB_START_NEXT_CH=
UNK);
>          }
> -    };
> -    start =3D qtest_readl(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_START);
> -    g_assert_cmpint(start & 1, =3D=3D, 0);
> -    sts =3D qtest_readl(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS);
> -    g_assert_cmpint(sts & 1, =3D=3D, 0);
> +    }
> +    tpm_sts =3D qtest_readl(s, CRB_ADDR_CTRL_STS);
> +    g_assert_cmpint(tpm_sts & 1, =3D=3D, 0);
>
> -    qtest_memread(s, raddr, rsp, rsp_size);
> +    /*
> +     * Read response in chunks
> +     */
> +
> +    unsigned char header[10];
> +    qtest_memread(s, raddr, header, sizeof(header));
> +
> +    uint32_t actual_response_size =3D ldl_be_p(&header[2]);

avoid mixing code & declaration per qemu coding style.

> +
> +    if (actual_response_size > rsp_size) {
> +        actual_response_size =3D rsp_size;
> +    }
> +
> +    for (size_t i =3D 0; i < actual_response_size; i +=3D chunk_size) {
> +        size_t to_read =3D i + chunk_size > actual_response_size
> +                       ? actual_response_size - i
> +                       : chunk_size;
> +        if (i > 0) {
> +            qtest_writel(s, CRB_ADDR_START, CRB_START_NEXT_CHUNK);
> +            tpm_wait_till_bit_clear(s, CRB_ADDR_START, CRB_START_NEXT_CH=
UNK);
> +        }
> +        qtest_memread(s, raddr, rsp + i, to_read);
> +    }
>  }
>
>  void tpm_util_startup(QTestState *s, tx_func *tx)
> diff --git a/tests/qtest/tpm-util.h b/tests/qtest/tpm-util.h
> index 0cb28dd6e5..681544e7d8 100644
> --- a/tests/qtest/tpm-util.h
> +++ b/tests/qtest/tpm-util.h
> @@ -24,10 +24,15 @@ typedef void (tx_func)(QTestState *s,
>                         const unsigned char *req, size_t req_size,
>                         unsigned char *rsp, size_t rsp_size);
>
> +void tpm_wait_till_bit_clear(QTestState *s, uint64_t addr, uint32_t mask=
);
>  void tpm_util_crb_transfer(QTestState *s,
>                             const unsigned char *req, size_t req_size,
>                             unsigned char *rsp, size_t rsp_size);
>
> +void tpm_util_crb_chunk_transfer(QTestState *s,
> +                                 const unsigned char *req, size_t req_si=
ze,
> +                                 unsigned char *rsp, size_t rsp_size);
> +
>  void tpm_util_startup(QTestState *s, tx_func *tx);
>  void tpm_util_pcrextend(QTestState *s, tx_func *tx);
>  void tpm_util_pcrread(QTestState *s, tx_func *tx,
> --
> 2.53.0
>


