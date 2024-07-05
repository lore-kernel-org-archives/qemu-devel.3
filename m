Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6F3C3271F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 10:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPfyw-00034p-SI; Fri, 05 Jul 2024 06:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sPfyv-0002yC-Dt
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 06:15:57 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sPfyj-0002ZS-2O
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 06:15:57 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a77d85f7fa3so41695366b.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 03:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720174542; x=1720779342; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VDmg6aUjig8YvI3EdlfPb9hk1JZLmu8bya0+kCdKXM4=;
 b=GAk5tZEjWhk7K+TvqWXxkrbxH3hO/dnu3hxoOf8in9tbQIzyNA3bKdV/L6OVJ9nxoN
 YSnB4XhjY0YLgkiXBjbMhf4AYfP/7jJqQf5fmAo5+oTdJeD//h9ujG6ixN4G53BV9DX9
 c2k0v2TjCfmjuBbWzxPPD15QCyzaUahs3yT8cIE2eubjGdiglMQ+VLs7T+uohFpNx7Ow
 eO6XRQJpJPJ+QGAzchUh1S4MOSVRqvpFZKloFBRWoQsVtG4lABeRiiD5Qa468Uu47PRN
 rHN5cXVT2Lb68y1eeDAvVEZC43iyG+ZKrNANDUgj+sws6Io1fkbJQZixI6Mw2fvmu2s1
 BH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720174542; x=1720779342;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VDmg6aUjig8YvI3EdlfPb9hk1JZLmu8bya0+kCdKXM4=;
 b=khgBdUeQS8HfbS7R/RllrCRd0VZF0eCjSYSoezn+VwbICwEPxx7mOJ+QKh/HxIDRBV
 uRtI+1C3oJPSLUWJc6ZrieIZiMmHoHB+2DA+cyoPp3H9jV1ka1Ey8sG3F4cCowtPGuO4
 egMaH8I2x0h+aAMrQXij4PQdaipusTXUr30zoTA6w/dStXNdPeRzWjATZZaiqZ94dStw
 woy9F9PDgMgllI6Gsv94fhP41pJFYJEpQJjZmD+6b21gRJ/54KO4phoDEdNSgfinkLNd
 64x3FXkNY9nHq8kdmLjXxZczybOUFVy5lqnLdSZU4//XeUxQULLzTDQwJPXXC5aL4yf/
 5ZTg==
X-Gm-Message-State: AOJu0YyHgF1O+TFKltwHYWTE1Y4jF7X7sK9L5IOfxzvHqI2DWBEJl1U/
 vHmJcvvFJN2LVJPiANJnVP2n6BT6CUruDxgeQi5Y8IbJQnikbVsu3SVbBoqmrG4o8JSPK9fA2sH
 9y6Qgip9zzY/dT8/G7Lda6wE+gjK5NssalkjQYg==
X-Google-Smtp-Source: AGHT+IF7FRfYU5D1rr3eOPrR1qPHE7sDdXF2O9+QMOtDRgGcHb1j1BRArrXHMvYy0QzP3FY8HlfHEFctjtHAL/KXDNU=
X-Received: by 2002:a17:907:3f08:b0:a75:35e2:2b2b with SMTP id
 a640c23a62f3a-a77bdd8691bmr309454266b.35.1720174542186; Fri, 05 Jul 2024
 03:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240705084047.857176-1-alex.bennee@linaro.org>
 <20240705084047.857176-23-alex.bennee@linaro.org>
In-Reply-To: <20240705084047.857176-23-alex.bennee@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 5 Jul 2024 13:15:26 +0300
Message-ID: <CAAjaMXbwMUW0b_5Q1UG9jqg1Ad4sejoxfMJAeX_MkMQ0nPon0g@mail.gmail.com>
Subject: Re: [PATCH v2 22/40] test/plugins: preserve the instruction record
 over translations
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, 
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Aleksandar Rikalo <arikalo@gmail.com>, Mads Ynddal <mads@ynddal.dk>,
 Yanan Wang <wangyanan55@huawei.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paul Burton <paulburton@kernel.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Fri, 5 Jul 2024 at 11:43, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> We are interested in the particular instruction so we should use a
> stable record for it. We could bring this down to physical address but
> for now vaddr + disas seems to do the trick.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/plugin/insn.c | 76 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 71 insertions(+), 5 deletions(-)
>
> diff --git a/tests/plugin/insn.c b/tests/plugin/insn.c
> index 524f9ddde8..baf2d07205 100644
> --- a/tests/plugin/insn.c
> +++ b/tests/plugin/insn.c
> @@ -43,6 +43,44 @@ typedef struct {
>      char *disas;
>  } Instruction;
>
> +/* A hash table to hold matched instructions */
> +static GHashTable *match_insn_records;
> +static GMutex match_hash_lock;
> +
> +
> +static Instruction * get_insn_record(const char *disas, uint64_t vaddr, =
Match *m)
> +{
> +    g_autofree char *str_hash =3D g_strdup_printf("%"PRIx64" %s", vaddr,=
 disas);
> +    Instruction *record;
> +
> +    g_mutex_lock(&match_hash_lock);
> +
> +    if (!match_insn_records) {
> +        match_insn_records =3D g_hash_table_new(g_str_hash, g_str_equal)=
;
> +    }
> +
> +    record =3D g_hash_table_lookup(match_insn_records, str_hash);
> +
> +    if (!record) {
> +        g_autoptr(GString) ts =3D g_string_new(str_hash);
> +
> +        record =3D g_new0(Instruction, 1);
> +        record->disas =3D g_strdup(disas);
> +        record->vaddr =3D vaddr;
> +        record->match =3D m;
> +
> +        g_hash_table_insert(match_insn_records, str_hash, record);
> +
> +        g_string_prepend(ts, "Created record for: ");
> +        g_string_append(ts, "\n");
> +        qemu_plugin_outs(ts->str);
> +    }
> +
> +    g_mutex_unlock(&match_hash_lock);
> +
> +    return record;
> +}
> +
>  /*
>   * Initialise a new vcpu with reading the register list
>   */
> @@ -131,16 +169,19 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, stru=
ct qemu_plugin_tb *tb)
>           * If we are tracking certain instructions we will need more
>           * information about the instruction which we also need to
>           * save if there is a hit.
> +         *
> +         * We only want one record for each occurrence of the matched
> +         * instruction.
>           */
>          if (matches->len) {
>              char *insn_disas =3D qemu_plugin_insn_disas(insn);
>              for (int j =3D 0; j < matches->len; j++) {
>                  Match *m =3D &g_array_index(matches, Match, j);
>                  if (g_str_has_prefix(insn_disas, m->match_string)) {
> -                    Instruction *rec =3D g_new0(Instruction, 1);
> -                    rec->disas =3D g_strdup(insn_disas);
> -                    rec->vaddr =3D qemu_plugin_insn_vaddr(insn);
> -                    rec->match =3D m;
> +                    Instruction *rec =3D get_insn_record(insn_disas,
> +                                                       qemu_plugin_insn_=
vaddr(insn),
> +                                                       m);
> +
>                      qemu_plugin_register_vcpu_insn_exec_cb(
>                          insn, vcpu_insn_matched_exec_before,
>                          QEMU_PLUGIN_CB_NO_REGS, rec);
> @@ -173,13 +214,38 @@ static void plugin_exit(qemu_plugin_id_t id, void *=
p)
>                                 qemu_plugin_u64_sum(insn_count));
>      }
>      qemu_plugin_outs(out->str);
> -
>      qemu_plugin_scoreboard_free(insn_count.score);
> +
> +    g_mutex_lock(&match_hash_lock);
> +
>      for (i =3D 0; i < matches->len; ++i) {
>          Match *m =3D &g_array_index(matches, Match, i);
> +        GHashTableIter iter;
> +        Instruction *record;
> +        qemu_plugin_u64 hit_e =3D qemu_plugin_scoreboard_u64_in_struct(m=
->counts, MatchCount, hits);
> +        uint64_t hits =3D qemu_plugin_u64_sum(hit_e);
> +
> +        g_string_printf(out, "Match: %s, hits %"PRId64"\n", m->match_str=
ing, hits);
> +        qemu_plugin_outs(out->str);
> +
> +        g_hash_table_iter_init(&iter, match_insn_records);
> +        while (g_hash_table_iter_next(&iter, NULL, (void **)&record)) {
> +            if (record->match =3D=3D m) {
> +                g_string_printf(out,
> +                                "  %"PRIx64": %s (hits %"PRId64")\n",
> +                                record->vaddr,
> +                                record->disas,
> +                                record->hits);
> +                qemu_plugin_outs(out->str);
> +            }
> +        }
> +
>          g_free(m->match_string);
>          qemu_plugin_scoreboard_free(m->counts);
>      }
> +
> +    g_mutex_unlock(&match_hash_lock);
> +
>      g_array_free(matches, TRUE);
>      g_array_free(sizes, TRUE);
>  }
> --
> 2.39.2

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

