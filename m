Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668CFC83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 12:22:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWZzs-00045c-IA; Tue, 01 Jul 2025 08:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1uWZze-0003vb-1V; Tue, 01 Jul 2025 08:21:49 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1uWZzZ-0006Nk-CE; Tue, 01 Jul 2025 08:21:44 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4a8244e8860so16296931cf.2; 
 Tue, 01 Jul 2025 05:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751372495; x=1751977295; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O9iMP6l19X8AdibSKn3h9xGb8Hcyk+IgkDV9YNNsqFk=;
 b=YpyXFBksmEGy3cE8k6fTNgm+B0NQMkUEliFr9RHZ26YhU9ItZbjUSWjY5wX06LM/aP
 pMXmlbBAIPcvDnud0JNIV7eftluGsPHl/ZcmT1/W0B9eZKgBYq3TzRN/07c/EMzYemCB
 fC7dw25Ael2dVzstQ4GymYrWX7xA4N3jRxWiHWCwp+tlhZo3jg368K1EZ+p2/+Wsi/dz
 5tmWwXf0maDykGnTC/AVpHB8vGG7+9An+o4qkWrS7DbXo/t+gF4hf2OouSyXm6n0kBJf
 +Mm/S6+VQD1rtL3QJO6qEK2+c4sptSFdsBCRXH0zEuix0ksvY7kV5L+e6XaRgmNG8t4g
 7Fvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751372495; x=1751977295;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O9iMP6l19X8AdibSKn3h9xGb8Hcyk+IgkDV9YNNsqFk=;
 b=CpTO0RMqV+y9aHzsweEreoAYrgqqabLMeF7TkzDhI5T/PqBCMn3oZuU6xW7b5v1xSp
 HvKtdsRuRdF2VGFuYJYWXU+7Jz8zUuCPHSZ64nbQkyWoedGBhLL3G5MnYzNF96q8v68a
 q9lKD+XI8XcrrGdr6QpqjtnJPaBOpc0cgAAu+aTvC6F2T92vuEhP3filXfbqAMryeK6D
 TgkSNf9U+/GVqqeRNePk/bNIcPf8qB49cke216/QDqP2wSeRQ0UKZmm34HF4To61A4Sv
 yEn+7pgFU4+KWoRpKIodxHKEJVqA1buanm8DroGfrSl2nG5m+LK4C/4rHqOalD3xGDUc
 OeUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVakXCqRfkNjD3079P9fxKmUZ0nWqWmcxid3ZI6Jr6OC5/XLqQa0Z4yg/VqV1X5tsLB5xvpc8klLg==@nongnu.org,
 AJvYcCXBqY6oHnDz+H3KTwi1UNnIgc+ZhY5wPk13sFqMC7fOks0egEwSeYrF+qIFaG34w1px9cZd/zkj1eXU4Q==@nongnu.org
X-Gm-Message-State: AOJu0Yw/sVZYKXZ1qs07nkdGq6H0/cprir7jOG3nGzO7FA4NhVAx7Wwg
 xv+RrgrkTuDiJzfrP4NEmOTKtIUmfbnuWmsegRURblUBykpgjNwo+5b5qnRq9gXUBxgReUFUBHe
 R0BIDSXM9GckFTyWOimES93eBrUmqWEE=
X-Gm-Gg: ASbGncv5gT9bfrZFWTe1Z4dtc57YLjnDvaMYXgh6loLXmfXu3/0s3t6yaQ8SfcBbOXL
 dMT3bYv7Yl92FPnMUj2f0uVyhkMzVnofuFYh3J8g6jQLcvlQvI0PBSIidh3MZvo2TI18ZJ4nueW
 2FHf10ic239GNUlQYIYpg1MrWblO7/BNJRXQqIXE31+ii9ztJt/RfiWsHGNVjT1ikzbErfFcEO4
 jW2
X-Google-Smtp-Source: AGHT+IGVgdUHgSEKgk/Zzmtubnjlpa6m8bSwkoQOSuLGx2HNhb/R7mLjLnvSUqVh1B0FlpDe8ARQYW+3zScfwxkjKnU=
X-Received: by 2002:a05:622a:513:b0:4a7:74ed:cd49 with SMTP id
 d75a77b69052e-4a7fcadbd48mr284601421cf.19.1751372494863; Tue, 01 Jul 2025
 05:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250624-propagate_tpm_error-v1-0-2171487a593d@redhat.com>
 <20250624-propagate_tpm_error-v1-3-2171487a593d@redhat.com>
In-Reply-To: <20250624-propagate_tpm_error-v1-3-2171487a593d@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 1 Jul 2025 16:21:23 +0400
X-Gm-Features: Ac12FXyKzuZJ7k7sxi1OzZWEflkZb489jIK7LZ6xjxMllETMqKtT1lT2jkTMdKQ
Message-ID: <CAJ+F1CLHo9BhcMkNL7Fv_EJ+kw-JQ0_Q3y-047uqsrCeTi31xQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] backends/tpm: Propagate vTPM error on migration
 failure
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, 
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82f.google.com
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

Hi

On Tue, Jun 24, 2025 at 4:26=E2=80=AFPM Arun Menon <armenon@redhat.com> wro=
te:
>
> - Introduce a new post_load_with_error() hook that will
>   take in the Error object as a parameter.

You should make this a different patch. I wonder if adding another
callback is the right approach, as only one of the two is called. I
would rather change the existing callback.

> - This error object is set if the loading of state fails.
> - The error can then be retrieved using QMP command
>   {"execute" : "query-migrate"}
>
> Buglink: https://issues.redhat.com/browse/RHEL-82826
>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  backends/tpm/tpm_emulator.c | 39 ++++++++++++++++++++-------------------
>  include/migration/vmstate.h |  1 +
>  migration/vmstate.c         |  4 +++-
>  3 files changed, 24 insertions(+), 20 deletions(-)
>
> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> index 4a234ab2c0b19b2604bf0dd8cb5f4540c72a9438..816134d7b4de00a75a3d0b928=
d160595b17be810 100644
> --- a/backends/tpm/tpm_emulator.c
> +++ b/backends/tpm/tpm_emulator.c
> @@ -819,7 +819,8 @@ static int tpm_emulator_get_state_blobs(TPMEmulator *=
tpm_emu)
>  static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
>                                         uint32_t type,
>                                         TPMSizedBuffer *tsb,
> -                                       uint32_t flags)
> +                                       uint32_t flags,
> +                                       Error **errp)
>  {
>      ssize_t n;
>      ptm_setstate pss;
> @@ -838,17 +839,17 @@ static int tpm_emulator_set_state_blob(TPMEmulator =
*tpm_emu,
>      /* write the header only */
>      if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_STATEBLOB, &pss,
>                               offsetof(ptm_setstate, u.req.data), 0, 0) <=
 0) {
> -        error_report("tpm-emulator: could not set state blob type %d : %=
s",
> -                     type, strerror(errno));
> +        error_setg(errp, "tpm-emulator: could not set state blob type %d=
 : %s",
> +                   type, strerror(errno));
>          return -1;
>      }
>
>      /* now the body */
>      n =3D qemu_chr_fe_write_all(&tpm_emu->ctrl_chr, tsb->buffer, tsb->si=
ze);
>      if (n !=3D tsb->size) {
> -        error_report("tpm-emulator: Writing the stateblob (type %d) "
> -                     "failed; could not write %u bytes, but only %zd",
> -                     type, tsb->size, n);
> +        error_setg(errp, "tpm-emulator: Writing the stateblob (type %d) =
"
> +                   "failed; could not write %u bytes, but only %zd",
> +                   type, tsb->size, n);
>          return -1;
>      }
>
> @@ -856,17 +857,17 @@ static int tpm_emulator_set_state_blob(TPMEmulator =
*tpm_emu,
>      n =3D qemu_chr_fe_read_all(&tpm_emu->ctrl_chr,
>                               (uint8_t *)&pss, sizeof(pss.u.resp));
>      if (n !=3D sizeof(pss.u.resp)) {
> -        error_report("tpm-emulator: Reading response from writing stateb=
lob "
> -                     "(type %d) failed; expected %zu bytes, got %zd", ty=
pe,
> -                     sizeof(pss.u.resp), n);
> +        error_setg(errp, "tpm-emulator: Reading response from writing "
> +                   "stateblob (type %d) failed; expected %zu bytes, "
> +                   "got %zd", type, sizeof(pss.u.resp), n);
>          return -1;
>      }
>
>      tpm_result =3D be32_to_cpu(pss.u.resp.tpm_result);
>      if (tpm_result !=3D 0) {
> -        error_report("tpm-emulator: Setting the stateblob (type %d) fail=
ed "
> -                     "with a TPM error 0x%x %s", type, tpm_result,
> -                     tpm_emulator_strerror(tpm_result));
> +        error_setg(errp, "tpm-emulator: Setting the stateblob (type %d) =
"
> +                   "failed with a TPM error 0x%x %s", type, tpm_result,
> +                   tpm_emulator_strerror(tpm_result));
>          return -1;
>      }
>
> @@ -880,7 +881,7 @@ static int tpm_emulator_set_state_blob(TPMEmulator *t=
pm_emu,
>   *
>   * Returns a negative errno code in case of error.
>   */
> -static int tpm_emulator_set_state_blobs(TPMBackend *tb)
> +static int tpm_emulator_set_state_blobs(TPMBackend *tb, Error **errp)
>  {
>      TPMEmulator *tpm_emu =3D TPM_EMULATOR(tb);
>      TPMBlobBuffers *state_blobs =3D &tpm_emu->state_blobs;
> @@ -894,13 +895,13 @@ static int tpm_emulator_set_state_blobs(TPMBackend =
*tb)
>
>      if (tpm_emulator_set_state_blob(tpm_emu, PTM_BLOB_TYPE_PERMANENT,
>                                      &state_blobs->permanent,
> -                                    state_blobs->permanent_flags) < 0 ||
> +                                    state_blobs->permanent_flags, errp) =
< 0 ||
>          tpm_emulator_set_state_blob(tpm_emu, PTM_BLOB_TYPE_VOLATILE,
>                                      &state_blobs->volatil,
> -                                    state_blobs->volatil_flags) < 0 ||
> +                                    state_blobs->volatil_flags, errp) < =
0 ||
>          tpm_emulator_set_state_blob(tpm_emu, PTM_BLOB_TYPE_SAVESTATE,
>                                      &state_blobs->savestate,
> -                                    state_blobs->savestate_flags) < 0) {
> +                                    state_blobs->savestate_flags, errp) =
< 0) {
>          return -EIO;
>      }
>
> @@ -948,12 +949,12 @@ static void tpm_emulator_vm_state_change(void *opaq=
ue, bool running,
>   *
>   * Returns negative errno codes in case of error.
>   */
> -static int tpm_emulator_post_load(void *opaque, int version_id)
> +static int tpm_emulator_post_load(void *opaque, int version_id, Error **=
errp)
>  {
>      TPMBackend *tb =3D opaque;
>      int ret;
>
> -    ret =3D tpm_emulator_set_state_blobs(tb);
> +    ret =3D tpm_emulator_set_state_blobs(tb, errp);
>      if (ret < 0) {
>          return ret;
>      }
> @@ -969,7 +970,7 @@ static const VMStateDescription vmstate_tpm_emulator =
=3D {
>      .name =3D "tpm-emulator",
>      .version_id =3D 0,
>      .pre_save =3D tpm_emulator_pre_save,
> -    .post_load =3D tpm_emulator_post_load,
> +    .post_load_with_error =3D tpm_emulator_post_load,
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_UINT32(state_blobs.permanent_flags, TPMEmulator),
>          VMSTATE_UINT32(state_blobs.permanent.size, TPMEmulator),
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 056781b1c21e737583f081594d9f88b32adfd674..1c6e89c3b08a3914cde6dce3b=
e5955978b6b7d0b 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -207,6 +207,7 @@ struct VMStateDescription {
>      MigrationPriority priority;
>      int (*pre_load)(void *opaque);
>      int (*post_load)(void *opaque, int version_id);
> +    int (*post_load_with_error)(void *opaque, int version_id, Error **er=
rp);
>      int (*pre_save)(void *opaque);
>      int (*post_save)(void *opaque);
>      bool (*needed)(void *opaque);
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 3f8c3d3c1dcfe14d70bab1f43b827244eb4bb385..c5dfffd9bad7285e819d4769e=
055d47157caab34 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -232,7 +232,9 @@ int vmstate_load_state(QEMUFile *f, const VMStateDesc=
ription *vmsd,
>          qemu_file_set_error(f, ret);
>          return ret;
>      }
> -    if (vmsd->post_load) {
> +    if (vmsd->post_load_with_error) {
> +        ret =3D vmsd->post_load_with_error(opaque, version_id, errp);
> +    } else if (vmsd->post_load) {
>          ret =3D vmsd->post_load(opaque, version_id);
>      }
>      trace_vmstate_load_state_end(vmsd->name, "end", ret);
>
> --
> 2.49.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

